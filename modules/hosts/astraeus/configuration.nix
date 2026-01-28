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
        inputs.proxmox-nixos.nixosModules.proxmox-ve
        self.diskoConfigurations.astraeus
        self.nixosModules.server
      ];

      boot = {
        loader = {
          efi.canTouchEfiVariables = true;
          grub = {
            enable = true;
            zfsSupport = true;
            efiSupport = true;
            device = "nodev";
            mirroredBoots = [
              {
                path = "/boot1";
                devices = [ "nodev" ];
              }
              {
                path = "/boot2";
                devices = [ "nodev" ];
              }
              {
                path = "/boot3";
                devices = [ "nodev" ];
              }
              {
                path = "/boot4";
                devices = [ "nodev" ];
              }
              {
                path = "/boot5";
                devices = [ "nodev" ];
              }
              {
                path = "/boot6";
                devices = [ "nodev" ];
              }
            ];
          };
        };

        supportedFilesystems = [ "zfs" ];
      };

      networking = {
        hostName = "astraeus";
        domain = "takoyaki.io";
        hostId = "d2a7615d";
        useDHCP = false;

        defaultGateway = "10.0.20.1";
        nameservers = [
          "10.0.20.1"
        ];

        interfaces.ens1f0.ipv4.addresses = [
          {
            address = "10.0.20.10";
            prefixLength = 24;
          }
        ];

        firewall.allowedTCPPorts = [
          22
          8006
        ];
      };

      services.proxmox-ve.enable = true;

      services.zfs = {
        autoScrub = {
          enable = true;
          interval = "weekly";
        };
        trim.enable = true;
      };

      zramSwap.enable = true;

      services.openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
      };

      environment.systemPackages = with pkgs; [
        git
      ];

      system.stateVersion = "25.11";
    };
}
