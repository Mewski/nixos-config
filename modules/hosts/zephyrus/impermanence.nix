{ inputs, ... }:
{
  flake.nixosModules.zephyrus =
    { lib, ... }:
    {
      imports = [ inputs.impermanence.nixosModules.impermanence ];

      fileSystems."/persist".neededForBoot = true;

      environment.persistence."/persist" = {
        hideMounts = true;

        directories = [
          "/etc/NetworkManager/system-connections"
          "/etc/ssh"
          "/var/lib/bluetooth"
          "/var/lib/flatpak"
          "/var/lib/nixos"
          "/var/lib/sbctl"
          "/var/lib/systemd/coredump"
          "/var/log"
        ];

        files = [
          "/etc/machine-id"
          "/etc/supergfxd.conf"
        ];

        users.mewski = {
          directories = [
            ".binaryninja"
            ".cache/spotify"
            ".claude"
            ".config/Bitwarden"
            ".config/discord"
            ".config/github-copilot"
            ".config/vesktop"
            ".config/spotify"
            ".gemini"
            ".local/share/fish"
            ".local/share/flatpak"
            ".local/share/libvirt"
            ".local/share/PrismLauncher"
            ".local/share/Steam"
            ".local/share/zed"
            ".nixos-config"
            ".steam"
            ".var/app"
            ".zen"
            "Documents"
            "Downloads"
            "Music"
            "Pictures"
            "Projects"
            "Videos"
            {
              directory = ".local/share/keyrings";
              mode = "0700";
            }
            {
              directory = ".ssh";
              mode = "0700";
            }
          ];

          files = [
            ".config/gh/hosts.yml"
            ".config/sops/age/keys.txt"
          ];
        };
      };

      boot.initrd.postResumeCommands = lib.mkAfter ''
        mount --mkdir -o subvol=/ /dev/mapper/cryptroot /mnt

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
