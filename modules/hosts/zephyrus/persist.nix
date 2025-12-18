{
  flake.nixosModules.zephyrus =
    { config, ... }:
    {
      environment.persistence."/persist" = {
        directories = [
          "/etc/mullvad-vpn"
          "/var/lib/flatpak"
        ];

        users.${config.preferences.user.username} = {
          directories = [
            "Documents"
            "Downloads"
            "Music"
            "Pictures"
            "Projects"
            "Videos"
            ".nixos-config"
            ".binaryninja"
            ".cache/cliphist"
            ".cache/spotify"
            ".claude"
            ".config/Bitwarden"
            ".config/discord"
            ".config/spotify"
            ".gemini"
            ".local/share/fish"
            ".local/share/flatpak"
            ".local/share/libvirt"
            ".local/share/PrismLauncher"
            ".local/share/zed"
            ".zen"
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
    };
}
