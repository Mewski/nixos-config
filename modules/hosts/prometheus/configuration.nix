{ inputs, self, ... }:
{
  flake.nixosConfigurations.prometheus = inputs.nixpkgs-stable.lib.nixosSystem {
    modules = [ self.nixosModules.prometheus ];
  };

  flake.nixosModules.prometheus =
    { pkgs, ... }:
    {
      imports = [
        inputs.disko.nixosModules.default
        self.diskoConfigurations.prometheus
        self.nixosModules.docker
        self.nixosModules.server
      ];

      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        loader.grub = {
          enable = true;
          efiSupport = true;
          efiInstallAsRemovable = true;
        };
      };

      networking = {
        hostName = "prometheus";
        domain = "takoyaki.io";
        useDHCP = false;

        firewall.allowedTCPPorts = [
          22
          443
        ];
      };

      zramSwap.enable = true;

      services.openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
      };

      services.qemuGuest.enable = true;

      environment.systemPackages = with pkgs; [
        git
      ];

      system.stateVersion = "25.11";
    };
}
