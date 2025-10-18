{
  flake.diskoConfigurations.zephyrus = {
    disko.devices = {
      disk.main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-SAMSUNG_MZVL22T0HDLB-00BT7_S7CFNE0X701590";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "1G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
