{ inputs, ... }:
{
  flake.nixosModules.impermanence =
    { config, lib, ... }:
    {
      imports = [
        inputs.impermanence.nixosModules.impermanence
      ];

      fileSystems."/persist".neededForBoot = true;

      environment.persistence = {
        "/persist" = {
          hideMounts = true;
          directories = [
            "/var/log"
            "/var/lib/bluetooth"
            "/var/lib/nixos"
            "/var/lib/sbctl"
            "/var/lib/systemd/coredump"
            "/etc/NetworkManager/system-connections"
            "/etc/ssh"
          ];
          files = [
            "/etc/machine-id"
          ];
          users.${config.preferences.user.username} = config.persist;
        };
      };

      boot.initrd.postResumeCommands = lib.mkAfter ''
        mkdir -p /mnt
        mount -o subvol=/ /dev/mapper/cryptroot /mnt
        if [[ -e /mnt/root ]]; then
          mkdir -p /mnt/snapshots
          timestamp=$(date --date="@$(stat -c %Y /mnt/root)" "+%Y-%m-%-d_%H:%M:%S")
          mv /mnt/root "/mnt/snapshots/$timestamp"
        fi

        delete_subvolume_recursively() {
          IFS=$'\n'
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/mnt/$i"
          done
          btrfs subvolume delete "$1"
        }

        for i in $(find /mnt/snapshots/ -maxdepth 1 -mtime +30); do
          delete_subvolume_recursively "$i"
        done

        btrfs subvolume create /mnt/root
        umount /mnt
      '';
    };

  flake.nixosModules.persist =
    { lib, ... }:
    {
      options.persist = lib.mkOption {
        type = lib.types.submodule {
          options = {
            directories = lib.mkOption {
              type = lib.types.listOf lib.types.anything;
              default = [ ];
            };
            files = lib.mkOption {
              type = lib.types.listOf lib.types.anything;
              default = [ ];
            };
          };
        };
        default = { };
      };
    };

  flake.homeModules.persist =
    { lib, ... }:
    {
      options.persist = lib.mkOption {
        type = lib.types.submodule {
          options = {
            directories = lib.mkOption {
              type = lib.types.listOf lib.types.anything;
              default = [ ];
            };
            files = lib.mkOption {
              type = lib.types.listOf lib.types.anything;
              default = [ ];
            };
          };
        };
        default = { };
      };
    };
}
