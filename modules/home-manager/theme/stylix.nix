{ pkgs, ... }:

{
  # Cursor
  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  # Opacity
  stylix.opacity = {
    applications = 0.8;
    terminal = 0.8;
    desktop = 1.0;
    popups = 0.8;
  };

  # Kitty
  stylix.targets.kitty = {
    variant256Colors = true;
  };

  # Zen Browser
  stylix.targets.zen-browser = {
    profileNames = [ "default" ];
  };
}
