{ inputs, self, ... }:
{
  flake.nixosConfigurations.aeolus = inputs.nixpkgs-stable.lib.nixosSystem {
    modules = [ self.nixosModules.aeolus ];
  };

  flake.nixosModules.aeolus =
    { pkgs, ... }:
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
          allowedUDPPorts = [ 51820 ];
        };
      };

      zramSwap.enable = true;

      system.stateVersion = "25.11";
    };
}
