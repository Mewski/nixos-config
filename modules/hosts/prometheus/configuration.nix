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
        self.nixosModules.server
        self.nixosModules.docker
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
        hostName = "prometheus";
        domain = "takoyaki.io";
        useDHCP = false;

        defaultGateway = "10.0.40.1";
        nameservers = [
          "10.0.40.1"
        ];

        interfaces.ens18.ipv4.addresses = [
          {
            address = "10.0.40.67";
            prefixLength = 24;
          }
        ];

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
