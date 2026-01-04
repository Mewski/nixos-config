{
  flake.nixosModules.fish = {
    programs.fish.enable = true;
  };

  flake.homeModules.fish = {
    programs.fish = {
      enable = true;

      loginShellInit = ''
        if test -z "$DISPLAY" -a "$XDG_VTNR" = "1"
          exec start-hyprland
        end
      '';
    };
  };
}
