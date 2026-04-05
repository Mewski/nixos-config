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
        self.diskoConfigurations.astraeus
        self.nixosModules.server
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

        kernelParams = [ "transparent_hugepage=always" ];
        kernel.sysctl."kernel.mm.ksm.run" = 1;
        supportedFilesystems = [ "zfs" ];
        zfs.devNodes = "/dev/disk/by-id";
      };

      networking = {
        hostName = "astraeus";
        domain = "takoyaki.io";
        hostId = "d2a7615d";
        useDHCP = false;

        defaultGateway = "10.0.50.1";
        defaultGateway6 = {
          address = "2600:1700:5820:5af4::1";
          interface = "vmbr0";
        };
        nameservers = [ "10.0.50.1" ];

        interfaces.vmbr0 = {
          ipv4.addresses = [
            {
              address = "10.0.50.20";
              prefixLength = 24;
            }
          ];
          ipv6.addresses = [
            {
              address = "2600:1700:5820:5af4::20";
              prefixLength = 64;
            }
          ];
        };

        firewall.allowedTCPPorts = [ 22 ];
      };

      services = {
        zfs = {
          autoScrub = {
            enable = true;
            interval = "weekly";
          };
          trim.enable = true;
        };

        openssh = {
          enable = true;
          settings = {
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
          };
        };
      };

      powerManagement.cpuFreqGovernor = "performance";

      environment.systemPackages = with pkgs; [
        cdrkit
        git
        openssl
        swtpm
      ];

      system.stateVersion = "25.11";
    };
}
