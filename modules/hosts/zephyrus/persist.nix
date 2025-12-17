{
  flake.nixosModules.zephyrus =
    { config, ... }:
    {
      environment.persistence."/persist" = {
        directories = [
          "/etc/mullvad-vpn"
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
            ".claude"
            ".config/Bitwarden"
            ".config/discord"
            ".config/spotify"
            ".gemini"
            ".local/share/fish"
            ".local/share/libvirt"
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
