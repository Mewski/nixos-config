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

        firewall = {
          enable = true;
          allowedTCPPorts = [
            22
            179
          ];
        };
      };

      zramSwap.enable = true;

      system.stateVersion = "25.11";
    };
}
