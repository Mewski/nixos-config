{
  flake.nixosModules.fish = {
    programs.fish = {
      enable = true;

      loginShellInit = ''
        if test -z "$DISPLAY" -a "$XDG_VTNR" = "1"
          exec Hyprland
        end
      '';
    };
  };
}
