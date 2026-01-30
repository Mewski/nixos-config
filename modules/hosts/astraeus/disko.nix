{
  flake.diskoConfigurations.astraeus =
    let
      disks = {
        ssd0 = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0JB00887";
        ssd1 = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0J512741";
        ssd2 = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNB0JB00115";
        ssd3 = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0J522696";
        ssd4 = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0JB00809";
        ssd5 = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0J511639";
      };

      mkBootDisk = device: espMountpoint: {
        type = "disk";
        inherit device;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = espMountpoint;
                mountOptions = [
                  "umask=0077"
                  "nofail"
                ];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "rpool";
              };
            };
          };
        };
      };
    in
    {
      disko.devices = {
        disk = {
          ssd0 = mkBootDisk disks.ssd0 "/boot";
          ssd1 = mkBootDisk disks.ssd1 "/boot-fallback-1";
          ssd2 = mkBootDisk disks.ssd2 "/boot-fallback-2";
          ssd3 = mkBootDisk disks.ssd3 "/boot-fallback-3";
          ssd4 = mkBootDisk disks.ssd4 "/boot-fallback-4";
          ssd5 = mkBootDisk disks.ssd5 "/boot-fallback-5";
        };

        zpool.rpool = {
          type = "zpool";
          mode = "raidz2";
          options = {
            ashift = "12";
            autotrim = "on";
            cachefile = "none";
          };
          rootFsOptions = {
            compression = "zstd";
            acltype = "posixacl";
            xattr = "sa";
            dnodesize = "auto";
            normalization = "formD";
            relatime = "on";
            "com.sun:auto-snapshot" = "false";
          };

          datasets = {
            root = {
              type = "zfs_fs";
              options.mountpoint = "legacy";
              mountpoint = "/";
            };
            nix = {
              type = "zfs_fs";
              options = {
                mountpoint = "legacy";
                atime = "off";
              };
              mountpoint = "/nix";
            };
            data = {
              type = "zfs_fs";
              options = {
                mountpoint = "none";
                recordsize = "64K";
              };
            };
          };
        };
      };
    };
}
