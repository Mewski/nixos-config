{ inputs, ... }:
{
  flake.nixosModules.astraeus =
    { pkgs, lib, ... }:
    let
      iptables = lib.getExe' pkgs.iptables "iptables";
      ip6tables = lib.getExe' pkgs.iptables "ip6tables";
    in
    {
      imports = [ inputs.proxmox-nixos.nixosModules.proxmox-ve ];

      nixpkgs.overlays = [ inputs.proxmox-nixos.overlays.x86_64-linux ];

      boot.kernel.sysctl = {
        "net.bridge.bridge-nf-call-iptables" = 0;
        "net.bridge.bridge-nf-call-ip6tables" = 0;
      };

      networking = {
        vlans = {
          vlan30 = {
            id = 30;
            interface = "ens1f0";
          };
          vlan40 = {
            id = 40;
            interface = "ens1f0";
          };
        };

        bridges = {
          vmbr0.interfaces = [ "vlan30" ];
          vmbr1.interfaces = [ "vlan40" ];
          vmbr2.interfaces = [ ];
        };

        interfaces.vmbr2 = {
          mtu = 1420;
          ipv4.addresses = [
            {
              address = "23.152.236.17";
              prefixLength = 28;
            }
          ];
          ipv6.addresses = [
            {
              address = "2602:fe18:1::1";
              prefixLength = 48;
            }
          ];
        };

        firewall.extraCommands = ''
          ${iptables} -I nixos-fw -i wg0 -p tcp --dport 8006 -j nixos-fw-refuse
          ${ip6tables} -I nixos-fw -i wg0 -p tcp --dport 8006 -j nixos-fw-refuse
          ${iptables} -I nixos-fw -i vmbr2 -p tcp --dport 8006 -j nixos-fw-refuse
          ${ip6tables} -I nixos-fw -i vmbr2 -p tcp --dport 8006 -j nixos-fw-refuse
          ${iptables} -I nixos-fw -i wg0 -s 23.152.236.0/28 -p tcp --dport 8006 -j nixos-fw-accept
          ${ip6tables} -I nixos-fw -i wg0 -s 2602:fe18::/48 -p tcp --dport 8006 -j nixos-fw-accept
          ${iptables} -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -o wg0 -j TCPMSS --clamp-mss-to-pmtu
          ${iptables} -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -i wg0 -j TCPMSS --clamp-mss-to-pmtu
          ${ip6tables} -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -o wg0 -j TCPMSS --clamp-mss-to-pmtu
          ${ip6tables} -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -i wg0 -j TCPMSS --clamp-mss-to-pmtu
        '';
      };

      systemd.services.proxmox-bridge-reattach = {
        after = [
          "vmbr0-netdev.service"
          "vmbr1-netdev.service"
          "vmbr2-netdev.service"
        ];
        wantedBy = [ "network.target" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        path = [ "/run/current-system/sw" ];
        script = ''
          for conf in /etc/pve/qemu-server/*.conf; do
            [ -f "$conf" ] || continue
            vmid=$(basename "$conf" .conf)
            grep -oP 'net\d+: .+' "$conf" | while IFS= read -r line; do
              idx=$(echo "$line" | grep -oP 'net\K\d+')
              bridge=$(echo "$line" | grep -oP 'bridge=\K[^,]+')
              tap="tap''${vmid}i''${idx}"
              if [ -d "/sys/class/net/$tap" ] && [ -d "/sys/class/net/$bridge" ]; then
                current=$(cat "/sys/class/net/$tap/master/uevent" 2>/dev/null | grep -oP 'INTERFACE=\K.+' || true)
                if [ "$current" != "$bridge" ]; then
                  echo "Re-attaching $tap to $bridge"
                  ip link set dev "$tap" master "$bridge" || true
                fi
              fi
            done
          done
        '';
      };

      services.proxmox-ve = {
        enable = true;
        ipAddress = "10.0.20.10";
        bridges = [
          "vmbr0"
          "vmbr1"
          "vmbr2"
        ];
      };
    };
}
