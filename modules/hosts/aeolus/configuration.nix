{ inputs, self, ... }:
{
  flake.nixosConfigurations.aeolus = inputs.nixpkgs-stable.lib.nixosSystem {
    modules = [ self.nixosModules.aeolus ];
  };

  flake.nixosModules.aeolus =
    { pkgs, lib, ... }:
    let
      iptables = lib.getExe' pkgs.iptables "iptables";
      ip6tables = lib.getExe' pkgs.iptables "ip6tables";
    in
    {
      imports = [
        inputs.disko.nixosModules.default
        self.diskoConfigurations.aeolus
        self.nixosModules.router
      ];

      boot = {
        kernelPackages = pkgs.linuxPackages_latest;

        loader.grub = {
          enable = true;
          efiSupport = true;
          efiInstallAsRemovable = true;
          device = "nodev";
        };
      };

      networking = {
        hostName = "aeolus";
        domain = "takoyaki.io";

        interfaces.lo = {
          ipv4.addresses = [
            {
              address = "23.152.236.1";
              prefixLength = 32;
            }
          ];
          ipv6.addresses = [
            {
              address = "2602:fe18::1";
              prefixLength = 128;
            }
          ];
        };

        firewall = {
          enable = true;
          allowedTCPPorts = [ 22 ];
          allowedUDPPorts = [
            51820
            51821
          ];
          extraStopCommands = ''
            ${iptables} -F FORWARD || true
            ${ip6tables} -F FORWARD || true
          '';
          extraCommands = ''
            ${iptables} -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
            ${ip6tables} -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
          '';
        };
      };

      systemd.services.set-default-src = {
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        path = [
          pkgs.iproute2
          pkgs.gawk
        ];
        script = ''
          gw=$(ip route show default | head -1 | awk '{print $3}')
          dev=$(ip route show default | head -1 | awk '{print $5}')
          [ -n "$gw" ] && [ -n "$dev" ] && ip route replace default via "$gw" dev "$dev" src 23.152.236.1
          gw6=$(ip -6 route show default | head -1 | awk '{print $3}')
          dev6=$(ip -6 route show default | head -1 | awk '{print $5}')
          [ -n "$gw6" ] && [ -n "$dev6" ] && ip -6 route replace default via "$gw6" dev "$dev6" src 2602:fe18::1
        '';
      };

      zramSwap.enable = true;

      system.stateVersion = "25.11";
    };
}
