{ inputs, self, ... }:
{
  flake.nixosConfigurations.astraeus = inputs.nixpkgs.lib.nixosSystem {
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

      nixpkgs.overlays = [
        inputs.proxmox-nixos.overlays.x86_64-linux
      ];

      boot = {
        loader = {
          efi.efiSysMountPoint = "/boot";
          efi.canTouchEfiVariables = true;
          grub = {
            enable = true;
            zfsSupport = true;
            efiSupport = true;
            device = "nodev";
            mirroredBoots = [
              {
                path = "/boot";
                devices = [ "nodev" ];
              }
              {
                path = "/boot-fallback-1";
                devices = [ "nodev" ];
              }
              {
                path = "/boot-fallback-2";
                devices = [ "nodev" ];
              }
              {
                path = "/boot-fallback-3";
                devices = [ "nodev" ];
              }
              {
                path = "/boot-fallback-4";
                devices = [ "nodev" ];
              }
              {
                path = "/boot-fallback-5";
                devices = [ "nodev" ];
              }
            ];
          };
        };

        supportedFilesystems = [ "zfs" ];
        zfs.devNodes = "/dev/disk/by-id";
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

      # services.proxmox-ve = {
      #   enable = true;
      #   ipAddress = "10.0.20.10";
      # };

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
