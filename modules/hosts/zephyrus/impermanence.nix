{ inputs, ... }:
{
  flake.nixosModules.zephyrus = {
    imports = [ inputs.impermanence.nixosModules.impermanence ];

    fileSystems."/persist".neededForBoot = true;

    environment.persistence."/persist" = {
      hideMounts = true;

      directories = [
        "/etc/NetworkManager/system-connections"
        "/etc/ssh"
        "/var/lib/bluetooth"
        "/var/lib/docker"
        "/var/lib/flatpak"
        "/var/lib/libvirt"
        "/var/lib/nixos"
        "/var/lib/sbctl"
        "/var/lib/systemd/backlight"
        "/var/lib/systemd/coredump"
        "/var/lib/alsa"
        "/var/log"
      ];

      files = [
        "/etc/machine-id"
        "/etc/supergfxd.conf"
        "/var/lib/systemd/credential.secret"
      ];

      users.mewski = {
        directories = [
          ".binaryninja"
          ".idapro"
          ".cache/spotify"
          ".cargo"
          ".claude"
          ".config/Bitwarden"
          ".config/Code"
          ".config/discord"
          ".config/github-copilot"
          ".config/obs-studio"
          ".config/obsidian"
          ".config/rstudio"
          ".config/Signal"
          ".config/spotify"
          ".config/zen"
          ".docker"
          ".gemini"
          ".local/share/atuin"
          ".local/share/fish"
          ".local/state/wireplumber"
          ".local/share/flatpak"
          ".local/share/libvirt"
          ".local/share/PrismLauncher"
          ".local/share/rstudio"
          ".local/share/Steam"
          ".local/share/zed"
          ".nixos-config"
          ".steam"
          ".var/app"
          ".vscode"
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

    boot.initrd.systemd.services.wipe-root = {
      wantedBy = [ "initrd.target" ];
      after = [ "cryptsetup.target" ];
      before = [ "sysroot.mount" ];
      unitConfig = {
        DefaultDependencies = "no";
      };
      serviceConfig = {
        Type = "oneshot";
      };
      script = ''
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
  };
}
