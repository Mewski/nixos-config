{
  flake.nixosModules.zephyrus = {
    environment.persistence."/persist" = {
      directories = [
        "/var/lib/flatpak"
      ];
      files = [
        "/etc/supergfxd.conf"
      ];

      users.mewski = {
        directories = [
          "Documents"
          "Downloads"
          "Music"
          "Pictures"
          "Projects"
          "Videos"
          ".nixos-config"
          ".binaryninja"
          ".cache/spotify"
          ".claude"
          ".config/Bitwarden"
          ".config/discord"
          ".config/github-copilot"
          ".config/spotify"
          ".gemini"
          ".local/share/fish"
          ".local/share/flatpak"
          ".local/share/libvirt"
          ".local/share/PrismLauncher"
          ".local/share/Steam"
          ".local/share/zed"
          ".steam"
          ".var/app"
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
