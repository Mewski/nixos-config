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
            ${iptables} -A FORWARD -i wg1 -d 23.152.236.16/28 -j ACCEPT
            ${iptables} -A FORWARD -i wg1 -d 23.152.236.32/28 -j ACCEPT
            ${iptables} -A FORWARD -i wg1 -j DROP
            ${ip6tables} -A FORWARD -i wg1 -d 2602:fe18:1::/48 -j ACCEPT
            ${ip6tables} -A FORWARD -i wg1 -d 2602:fe18:2::/48 -j ACCEPT
            ${ip6tables} -A FORWARD -i wg1 -j DROP
            ${iptables} -A FORWARD -i wg0 -s 23.152.236.32/28 -d 23.152.236.16/28 -j DROP
            ${iptables} -A FORWARD -i wg0 -s 23.152.236.16/28 -d 23.152.236.32/28 -j DROP
            ${ip6tables} -A FORWARD -i wg0 -s 2602:fe18:2::/48 -d 2602:fe18:1::/48 -j DROP
            ${ip6tables} -A FORWARD -i wg0 -s 2602:fe18:1::/48 -d 2602:fe18:2::/48 -j DROP
          '';
        };
      };

      zramSwap.enable = true;

      system.stateVersion = "25.11";
    };
}
