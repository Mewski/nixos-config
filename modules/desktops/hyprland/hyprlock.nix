{
  flake.homeModules.hyprland = {
    programs.hyprlock = {
      enable = true;
      settings.general.hide_cursor = true;
    };
  };
}
