{ inputs, self, ... }:
{
  flake.nixosConfigurations.astraeus = inputs.nixpkgs-stable.lib.nixosSystem {
    modules = [ self.nixosModules.astraeus ];
  };

  flake.nixosModules.astraeus = {
    imports = [
      inputs.disko.nixosModules.default

      self.diskoConfigurations.astraeus

      self.nixosModules.server
    ];

    boot = {
      loader.grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        mirroredBoots = [
          {
            path = "/boot/efis/ssd0";
            devices = [ "nodev" ];
          }
          {
            path = "/boot/efis/ssd1";
            devices = [ "nodev" ];
          }
          {
            path = "/boot/efis/ssd2";
            devices = [ "nodev" ];
          }
          {
            path = "/boot/efis/ssd3";
            devices = [ "nodev" ];
          }
          {
            path = "/boot/efis/ssd4";
            devices = [ "nodev" ];
          }
          {
            path = "/boot/efis/ssd5";
            devices = [ "nodev" ];
          }
        ];
      };

      loader.efi.canTouchEfiVariables = false;

      supportedFilesystems = [ "zfs" ];
      zfs.devNodes = "/dev/disk/by-id";
    };

    networking = {
      hostName = "astraeus";
      hostId = "db2e0ee7";

      useDHCP = false;

      interfaces.ens1f0.ipv4.addresses = [
        {
          address = "10.0.1.50";
          prefixLength = 24;
        }
      ];

      defaultGateway = "10.0.1.1";
      nameservers = [
        "10.0.1.1"
        "1.1.1.1"
      ];

      firewall = {
        enable = true;

        allowedTCPPorts = [ 22 ];

        allowedUDPPorts = [ ];
      };
    };

    services.openssh.enable = true;

    services.zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };

    system.stateVersion = "25.11";
  };
}
