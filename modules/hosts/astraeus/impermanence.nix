{ inputs, ... }:
{
  flake.nixosModules.astraeus =
    { lib, ... }:
    {
      imports = [ inputs.impermanence.nixosModules.impermanence ];

      fileSystems."/persist".neededForBoot = true;

      environment.persistence."/persist" = {
        hideMounts = true;
        directories = [
          "/etc/ssh"
          "/var/gitlab"
          "/var/lib/gitlab"
          "/var/lib/nixos"
          "/var/lib/postgresql"
          "/var/lib/redis-gitlab"
          "/var/lib/sbctl"
          "/var/lib/systemd/coredump"
          "/var/lib/docker"
          "/var/lib/private/gitlab-runner"
          "/var/log"
        ];
        files = [
          "/etc/machine-id"
        ];

        users.mewski = {
          directories = [
            {
              directory = ".ssh";
              mode = "0700";
            }
          ];
        };
      };

      boot.initrd.postDeviceCommands = lib.mkAfter ''
        mount --mkdir -o subvol=/ /dev/disk/by-id/ata-SAMSUNG_MZ7LM1T9HMJP-00005_S2TVNX0J511639-part1 /mnt

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

        for i in $(find /mnt/snapshots/ -maxdepth 1 -mtime +7); do
          delete_subvolume_recursively "$i"
        done

        btrfs subvolume create /mnt/root
        umount /mnt
      '';
    };
}
