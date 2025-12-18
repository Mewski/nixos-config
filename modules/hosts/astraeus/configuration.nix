{ inputs, self, ... }:
{
  flake.nixosConfigurations.astraeus = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.astraeus ];
  };

  flake.nixosModules.astraeus =
    { lib, ... }:
    {
      imports = [
        inputs.disko.nixosModules.default

        self.diskoConfigurations.astraeus

        self.nixosModules.server
      ];

      boot = {
        loader.grub = {
          enable = true;
          efiSupport = false;
          mirroredBoots = [
            {
              devices = [ "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0JB00809" ];
              path = "/boot";
            }
            {
              devices = [ "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0J522696" ];
              path = "/boot-fallback1";
            }
            {
              devices = [ "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0J511639" ];
              path = "/boot-fallback2";
            }
          ];
        };

        supportedFilesystems = [ "zfs" ];
        zfs.devNodes = "/dev/disk/by-id";
      };

      networking = {
        hostName = "astraeus";
        hostId = "a57rae05";

        useDHCP = lib.mkDefault true;

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
