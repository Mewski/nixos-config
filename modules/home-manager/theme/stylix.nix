{ pkgs, ... }:

{
  # Disable unwanted Stylix modules
  stylix.targets.nixcord.enable = false;

  # Cursor
  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  # Opacity
  stylix.opacity = {
    applications = 1.0;
    terminal = 0.8;
    desktop = 0.8;
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
