{
  flake.diskoConfigurations.zephyrus = {
    disko.devices = {
      disk.main = {
        device = "/dev/disk/by-id/nvme-SAMSUNG_MZVL22T0HDLB-00BT7_S7CFNE0X701590";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            esp = {
              name = "ESP";
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            swap = {
              name = "cryptswap";
              size = "38G";
              type = "8309";
              content = {
                type = "luks";
                name = "cryptswap";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "swap";
                };
              };
            };
            root = {
              name = "cryptroot";
              size = "100%";
              type = "8309";
              content = {
                type = "luks";
                name = "cryptroot";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-L"
                    "nixos"
                    "-f"
                  ];
                  mountOptions = [
                    "ssd"
                    "noatime"
                    "compress=zstd"
                  ];
                  subvolumes = {
                    "@root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "ssd"
                        "noatime"
                        "compress=zstd"
                      ];
                    };
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "ssd"
                        "noatime"
                        "compress=zstd"
                      ];
                    };
                    "@persist" = {
                      mountpoint = "/persist";
                      mountOptions = [
                        "ssd"
                        "noatime"
                        "compress=zstd"
                      ];
                    };
                    "@log" = {
                      mountpoint = "/var/log";
                      mountOptions = [
                        "ssd"
                        "noatime"
                        "compress=zstd"
                      ];
                    };
                    "@home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "ssd"
                        "noatime"
                        "compress=zstd"
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
