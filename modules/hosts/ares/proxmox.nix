{ inputs, ... }:
{
  flake.nixosModules.ares = {
    imports = [ inputs.proxmox-nixos.nixosModules.proxmox-ve ];

    nixpkgs.overlays = [
      inputs.proxmox-nixos.overlays.x86_64-linux
      (_final: prev: {
        perl540 = prev.perl540.override {
          overrides = pkgs: {
            CryptOpenSSLRSA = pkgs.CryptOpenSSLRSA.overrideAttrs (_old: {
              version = "0.33";
              src = prev.fetchurl {
                url = "mirror://cpan/authors/id/T/TO/TODDR/Crypt-OpenSSL-RSA-0.33.tar.gz";
                hash = "sha256-xpsIlwnB+UE/s9MmzpdVdK0JXEQG8HnfqlYjGurpjXA=";
              };
            });
          };
        };
      })
    ];

    boot.kernel.sysctl = {
      "net.bridge.bridge-nf-call-iptables" = 0;
      "net.bridge.bridge-nf-call-ip6tables" = 0;
    };

    networking.bridges = {
      vmbr0.interfaces = [ "ens1f0" ];
      vmbr1.interfaces = [ ];
      vmbr2.interfaces = [ ];
      vmbr3.interfaces = [ ];
    };

    networking.firewall.allowedTCPPorts = [ 8006 ];

    systemd.services.proxmox-bridge-reattach = {
      after = [
        "vmbr0-netdev.service"
        "vmbr1-netdev.service"
        "vmbr2-netdev.service"
        "vmbr3-netdev.service"
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

    systemd.tmpfiles.rules = [
      "d /usr/sbin 0755 root root -"
      "L+ /usr/sbin/qm - - - - /run/current-system/sw/bin/qm"
      "L+ /usr/sbin/swtpm_setup - - - - /run/current-system/sw/bin/swtpm_setup"
      "L+ /usr/sbin/swtpm - - - - /run/current-system/sw/bin/swtpm"
    ];

    services.proxmox-ve = {
      enable = true;
      ipAddress = "10.0.50.10";
      bridges = [
        "vmbr0"
        "vmbr1"
        "vmbr2"
        "vmbr3"
      ];
    };
  };
}
