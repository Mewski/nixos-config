{ inputs, ... }:
{
  flake.nixosModules.ares =
    { pkgs, lib, ... }:
    {
      imports = [ inputs.proxmox-nixos.nixosModules.proxmox-ve ];

      nixpkgs.overlays = [ inputs.proxmox-nixos.overlays.x86_64-linux ];

      environment.etc."ssl/openssl-override.cnf".source =
        pkgs.runCommand "openssl-cnf-patched" { } ''
          sed 's/# activate = 1/activate = 1/' ${pkgs.openssl.out}/etc/ssl/openssl.cnf > $out
        '';

      systemd.services.pveproxy.serviceConfig.ExecStartPre = lib.mkBefore [
        "+${pkgs.bash}/bin/bash -c '${pkgs.util-linux}/bin/mount --bind /etc/ssl/openssl-override.cnf ${pkgs.openssl.out}/etc/ssl/openssl.cnf'"
      ];

      boot.kernel.sysctl = {
        "net.bridge.bridge-nf-call-iptables" = 0;
        "net.bridge.bridge-nf-call-ip6tables" = 0;
      };

      networking.bridges = {
        vmbr0.interfaces = [ "ens1f0" ];
        vmbr1.interfaces = [ ];
        vmbr2.interfaces = [ ];
      };

      networking.firewall.allowedTCPPorts = [ 8006 ];

      systemd.services.proxmox-bridge-reattach = {
        after = [
          "vmbr0-netdev.service"
          "vmbr1-netdev.service"
          "vmbr2-netdev.service"
          "pve-guests.service"
        ];
        wants = [ "pve-guests.service" ];
        wantedBy = [ "multi-user.target" ];
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
        ipAddress = "10.0.50.10";
        bridges = [
          "vmbr0"
          "vmbr1"
          "vmbr2"
        ];
      };
    };
}
