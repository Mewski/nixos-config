{
  flake.diskoConfigurations.ares = {
    disko.devices = {
      disk.ssd0 = {
        type = "disk";
        device = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0JB00808";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
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

      zpool.rpool = {
        type = "zpool";
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

          vz = {
            type = "zfs_fs";
            options.mountpoint = "legacy";
            mountpoint = "/var/lib/vz";
          };
        };
      };
    };
  };
}
