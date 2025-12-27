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
                  mountpoint = "/boot";
                  mountOptions = [ "umask=0077" ];
                };
              };

              root = {
                size = "100%";
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
              root = {
                size = "100%";
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
              root = {
                size = "100%";
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
              root = {
                size = "100%";
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
              root = {
                size = "100%";
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
              root = {
                size = "100%";
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-f"
                    "-d raid10"
                    "-m raid10"
                    "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0JB00887-part2"
                    "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0J512741-part1"
                    "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNB0JB00115-part1"
                    "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0J522696-part1"
                    "/dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0JB00809-part1"
                  ];
                  subvolumes = {
                    "root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };

                    "nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };

                    "persist" = {
                      mountpoint = "/persist";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
