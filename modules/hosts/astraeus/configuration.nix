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
        kernelPackages = pkgs.linuxPackages_latest;

        loader = {
          systemd-boot.enable = false;
          efi.canTouchEfiVariables = true;
        };

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
              address = "10.0.40.10";
              prefixLength = 24;
            }
          ];
          ipv6.addresses = [
            {
              address = "2601:244:4b06:5be2::10";
              prefixLength = 64;
            }
          ];
        };

        defaultGateway = "10.0.40.1";
        defaultGateway6 = "2601:244:4b06:5be2::1";
        nameservers = [
          "10.0.40.1"
          "2601:244:4b06:5be2::1"
        ];

        firewall = {
          enable = true;
          allowedTCPPorts = [
            22
            443
          ];
        };
      };

      zramSwap = {
        enable = true;
        memoryMax = 16 * 1024 * 1024 * 1024;
      };

      services.openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
        extraConfig = ''
          Match LocalAddress 10.0.40.10
            AllowUsers mewski git

          Match LocalAddress 2601:244:4b06:5be2::10
            AllowUsers git
        '';
      };

      environment.systemPackages = with pkgs; [
        git
        sbctl
      ];

      system.stateVersion = "25.11";
    };
}
