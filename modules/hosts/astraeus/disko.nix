{
  flake.diskoConfigurations.astraeus =
    let
      btrfsMountOptions = [
        "compress=zstd"
        "noatime"
      ];

      mkDisk = device: partitions: {
        type = "disk";
        inherit device;
        content = {
          type = "gpt";
          inherit partitions;
        };
      };

      mkRootPartition = {
        size = "100%";
      };

      disks = {
        ssd0 = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0JB00887";
        ssd1 = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0J512741";
        ssd2 = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNB0JB00115";
        ssd3 = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0J522696";
        ssd4 = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0JB00809";
        ssd5 = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0J511639";
      };
    in
    {
      disko.devices.disk = {
        ssd0 = mkDisk disks.ssd0 {
          ESP = {
            priority = 1;
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          root = mkRootPartition;
        };

        ssd1 = mkDisk disks.ssd1 { root = mkRootPartition; };
        ssd2 = mkDisk disks.ssd2 { root = mkRootPartition; };
        ssd3 = mkDisk disks.ssd3 { root = mkRootPartition; };
        ssd4 = mkDisk disks.ssd4 { root = mkRootPartition; };

        ssd5 = mkDisk disks.ssd5 {
          root = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [
                "-f"
                "-d"
                "raid10"
                "-m"
                "raid10"
                "${disks.ssd0}-part2"
                "${disks.ssd1}-part1"
                "${disks.ssd2}-part1"
                "${disks.ssd3}-part1"
                "${disks.ssd4}-part1"
              ];
              subvolumes = {
                "root" = {
                  mountpoint = "/";
                  mountOptions = btrfsMountOptions;
                };
                "nix" = {
                  mountpoint = "/nix";
                  mountOptions = btrfsMountOptions;
                };
                "persist" = {
                  mountpoint = "/persist";
                  mountOptions = btrfsMountOptions;
                };
              };
            };
          };
        };
      };
    };
}
