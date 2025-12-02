{ inputs, ... }:
{
  flake.nixosModules.impermanence =
    { lib, ... }:
    {
      imports = [ inputs.impermanence.nixosModules.impermanence ];

      fileSystems."/persist".neededForBoot = true;

      environment.persistence."/persist" = {
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
      };

      boot.initrd.postResumeCommands = lib.mkAfter ''
        mkdir -p /mnt
        mount -o subvol=/ /dev/mapper/cryptroot /mnt

        delete_subvolume_recursively() {
          IFS=$'\n'
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/mnt/$i"
          done
          btrfs subvolume delete "$1"
        }

        if [[ -e /mnt/root ]]; then
          delete_subvolume_recursively /mnt/root
        fi

        btrfs subvolume create /mnt/root
        umount /mnt
      '';
    };
}
