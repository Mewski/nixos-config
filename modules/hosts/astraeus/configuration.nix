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

        self.nixosModules.docker

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

        interfaces.ens1f0 = {
          ipv4.addresses = [
            {
              address = "10.0.1.51";
              prefixLength = 24;
            }
          ];
          ipv6.addresses = [
            {
              address = "2601:244:4b06:5be1::51";
              prefixLength = 64;
            }
          ];
        };

        defaultGateway = "10.0.1.1";
        defaultGateway6 = "2601:244:4b06:5be1::1";

        nameservers = [
          "10.0.1.1"
          "2601:244:4b06:5be1::1"
        ];

        firewall = {
          enable = true;
          allowedTCPPorts = [ 22 ];
        };
      };

      zramSwap = {
        enable = true;
        memoryMax = 64 * 1024 * 1024 * 1024;
      };

      services.openssh = {
        enable = true;

        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };

        extraConfig = ''
          Match LocalAddress 10.0.1.51
            AllowUsers mewski git

          Match LocalAddress 2601:244:4b06:5be1::51
            AllowUsers git
        '';
      };

      environment.systemPackages = [
        pkgs.sbctl
      ];

      system.stateVersion = "25.11";
    };
}
