{
  flake.homeModules.hyprlock = {
    programs.hyprlock = {
      enable = true;
      settings.general.hide_cursor = true;
    };
  };
}
