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
        inputs.lanzaboote.nixosModules.lanzaboote
        self.diskoConfigurations.ares
        self.nixosModules.server
      ];

      boot = {
        loader = {
          systemd-boot.enable = false;
          efi.efiSysMountPoint = "/boot";
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

        supportedFilesystems = [ "zfs" ];
        zfs.devNodes = "/dev/disk/by-id";
      };

      networking = {
        hostName = "ares";
        domain = "takoyaki.io";
        hostId = "fad41e6c";
        useDHCP = false;

        defaultGateway = "10.0.50.1";
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
