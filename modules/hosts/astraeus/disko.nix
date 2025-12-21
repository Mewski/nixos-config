{
  flake.diskoConfigurations.astraeus = {
    disko.devices = {
      disk = {
        ssd0 = {
          type = "disk";
          device = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0JB00887";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                priority = 1;
                size = "1G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot/efis/ssd0";
                  mountOptions = [ "umask=0077" ];
                };
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
          device = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0J512741";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                priority = 1;
                size = "1G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot/efis/ssd1";
                  mountOptions = [ "umask=0077" ];
                };
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
          device = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNB0JB00115";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                priority = 1;
                size = "1G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot/efis/ssd2";
                  mountOptions = [ "umask=0077" ];
                };
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
        ssd3 = {
          type = "disk";
          device = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0J522696";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                priority = 1;
                size = "1G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot/efis/ssd3";
                  mountOptions = [ "umask=0077" ];
                };
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
        ssd4 = {
          type = "disk";
          device = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0JB00809";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                priority = 1;
                size = "1G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot/efis/ssd4";
                  mountOptions = [ "umask=0077" ];
                };
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
        ssd5 = {
          type = "disk";
          device = "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0J511639";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                priority = 1;
                size = "1G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot/efis/ssd5";
                  mountOptions = [ "umask=0077" ];
                };
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
          mode = "raidz2";
          options = {
            ashift = "12";
            autotrim = "on";
          };
          rootFsOptions = {
            compression = "lz4";
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
              options = {
                mountpoint = "legacy";
                atime = "off";
              };
            };
            "home" = {
              type = "zfs_fs";
              mountpoint = "/home";
              options.mountpoint = "legacy";
            };
            "boot" = {
              type = "zfs_fs";
              mountpoint = "/boot";
              options.mountpoint = "legacy";
            };
            "var" = {
              type = "zfs_fs";
              mountpoint = "/var";
              options.mountpoint = "legacy";
            };
            "var/log" = {
              type = "zfs_fs";
              mountpoint = "/var/log";
              options.mountpoint = "legacy";
            };
            "var/lib" = {
              type = "zfs_fs";
              mountpoint = "/var/lib";
              options = {
                mountpoint = "legacy";
                recordsize = "16K";
              };
            };
            "tmp" = {
              type = "zfs_fs";
              mountpoint = "/tmp";
              options = {
                mountpoint = "legacy";
                sync = "disabled";
                "com.sun:auto-snapshot" = "false";
              };
            };
          };
        };
      };
    };
  };
}
