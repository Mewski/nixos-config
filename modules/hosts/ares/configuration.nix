{ inputs, self, ... }:
{
  flake.nixosConfigurations.ares = inputs.nixpkgs-stable.lib.nixosSystem {
    modules = [ self.nixosModules.ares ];
  };

  flake.nixosModules.ares =
    { pkgs, ... }:
    {
      imports = [
        inputs.disko.nixosModules.default
        self.diskoConfigurations.ares
        self.nixosModules.server
      ];

      boot = {
        kernel.sysctl = {
          "net.ipv4.ip_forward" = 1;
          "net.ipv6.conf.all.forwarding" = 1;
        };

        loader = {
          efi.efiSysMountPoint = "/boot";
          efi.canTouchEfiVariables = true;
          grub = {
            enable = true;
            zfsSupport = true;
            efiSupport = true;
            device = "nodev";
          };
        };

        supportedFilesystems = [ "zfs" ];
        zfs.devNodes = "/dev/disk/by-id";
      };

      networking = {
        hostName = "ares";
        domain = "takoyaki.io";
        hostId = "fad41e6c";
        useDHCP = false;

        nameservers = [ "10.0.50.1" ];

        interfaces.vmbr0 = {
          ipv4.addresses = [
            {
              address = "10.0.50.10";
              prefixLength = 24;
            }
          ];
          ipv6.addresses = [
            {
              address = "2600:1700:5820:5af4::10";
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
