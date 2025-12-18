{
  flake.diskoConfigurations.astraeus = {
    disko.devices = {
      disk = {
        ssd0 = {
          type = "disk";
          device = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0JB00809";
          content = {
            type = "gpt";
            partitions = {
              boot = {
                priority = 1;
                size = "1M";
                type = "EF02";
              };
              root = {
                size = "100%";
                content = {
                  type = "zfs";
                  pool = "rpool";
                };
              };
            };
          };
        };
        ssd1 = {
          type = "disk";
          device = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0J522696";
          content = {
            type = "gpt";
            partitions = {
              boot = {
                priority = 1;
                size = "1M";
                type = "EF02";
              };
              root = {
                size = "100%";
                content = {
                  type = "zfs";
                  pool = "rpool";
                };
              };
            };
          };
        };
        ssd2 = {
          type = "disk";
          device = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0J511639";
          content = {
            type = "gpt";
            partitions = {
              boot = {
                priority = 1;
                size = "1M";
                type = "EF02";
              };
              root = {
                size = "100%";
                content = {
                  type = "zfs";
                  pool = "rpool";
                };
              };
            };
          };
        };
      };
      zpool = {
        rpool = {
          type = "zpool";
          mode = "raidz";
          options = {
            ashift = "12";
            autotrim = "on";
          };
          rootFsOptions = {
            compression = "zstd";
            acltype = "posixacl";
            xattr = "sa";
            dnodesize = "auto";
            normalization = "formD";
            relatime = "on";
            canmount = "off";
            mountpoint = "none";
          };
          datasets = {
            "root" = {
              type = "zfs_fs";
              mountpoint = "/";
              options.mountpoint = "legacy";
            };
            "nix" = {
              type = "zfs_fs";
              mountpoint = "/nix";
              options.mountpoint = "legacy";
            };
            "home" = {
              type = "zfs_fs";
              mountpoint = "/home";
              options.mountpoint = "legacy";
            };
          };
        };
      };
    };
  };
}
