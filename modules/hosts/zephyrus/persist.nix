{
  flake.nixosModules.zephyrus =
    { config, ... }:
    {
      environment.persistence."/persist".users.${config.preferences.user.username} = {
        directories = [
          "Documents"
          "Downloads"
          "Music"
          "Pictures"
          "Projects"
          "Videos"
          ".nixos-config"
          ".claude"
          ".config/Bitwarden"
          ".config/discord"
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
}
