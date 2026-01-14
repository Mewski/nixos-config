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
          cat = "bat";
          ls = "eza";
          ll = "eza -la";
          la = "eza -a";
          lt = "eza --tree";
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

      bat.enable = true;
      eza.enable = true;
      fd.enable = true;
      ripgrep.enable = true;

      starship = {
        enable = true;
        enableFishIntegration = true;
      };
    };
  };
}
