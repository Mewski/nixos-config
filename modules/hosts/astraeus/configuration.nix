{ inputs, self, ... }:
{
  flake.nixosConfigurations.astraeus = inputs.nixpkgs-stable.lib.nixosSystem {
    modules = [ self.nixosModules.astraeus ];
  };

  flake.nixosModules.astraeus =
    { pkgs, ... }:
    {
      imports = [
        inputs.disko.nixosModules.default
        inputs.lanzaboote.nixosModules.lanzaboote

        self.diskoConfigurations.astraeus

        self.nixosModules.gitlab

        self.nixosModules.server
      ];

      boot = {
        loader.systemd-boot.enable = false;
        loader.efi.canTouchEfiVariables = true;

        lanzaboote = {
          enable = true;
          pkiBundle = "/var/lib/sbctl";
          autoGenerateKeys.enable = true;
          autoEnrollKeys = {
            enable = true;
            autoReboot = true;
          };
        };
      };

      networking = {
        hostName = "astraeus";

        useDHCP = false;

        interfaces.ens1f0.ipv4.addresses = [
          {
            address = "10.0.1.51";
            prefixLength = 24;
          }
        ];

        defaultGateway = "10.0.1.1";
        nameservers = [ "10.0.1.1" ];

        firewall = {
          enable = true;

          allowedTCPPorts = [ ];

          allowedUDPPorts = [ ];
        };
      };

      zramSwap = {
        enable = true;
        memoryMax = 64 * 1024 * 1024 * 1024;
      };

      services.openssh.enable = true;

      environment.systemPackages = [
        pkgs.sbctl
      ];

      system.stateVersion = "25.11";
    };
}
