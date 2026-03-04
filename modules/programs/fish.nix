{
  flake.nixosModules.fish = {
    programs.fish.enable = true;
  };

  flake.homeModules.fish = {
    programs = {
      fish = {
        enable = true;

        loginShellInit = ''
          if test -z "$DISPLAY" -a "$XDG_VTNR" = "1"
            exec start-hyprland
          end
        '';

        shellAliases = {
          ls = "eza --icons";
          ll = "eza -la --icons";
          la = "eza -a --icons";
          lt = "eza --tree --icons";
          find = "fd";
          grep = "rg";
        };
      };

      zoxide = {
        enable = true;
        enableFishIntegration = true;
        options = [
          "--cmd"
          "cd"
        ];
      };

      fzf = {
        enable = true;
        enableFishIntegration = true;
      };

      atuin = {
        enable = true;
        enableFishIntegration = true;
        flags = [ "--disable-up-arrow" ];
      };

      bat.enable = true;
      eza.enable = true;
      fd.enable = true;
      fastfetch.enable = true;
      navi.enable = true;
      ripgrep.enable = true;
      tealdeer.enable = true;
      yazi.enable = true;
    };
  };
}
