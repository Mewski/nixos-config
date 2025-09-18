{ pkgs, ... }:

{
  # Cursor theme configuration
  stylix.cursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  # Application opacity settings
  stylix.opacity = {
    applications = 1.0;
    desktop = 0.8;
    popups = 0.8;
    terminal = 0.8;
  };

  # Application-specific Stylix targets
  stylix.targets = {
    # Disable Stylix for Kitty to use custom settings
    kitty = {
      variant256Colors = true;
    };

    # Enable Stylix for Zen Browser profiles
    zen-browser = {
      profileNames = [ "default" ];
    };
  };
}
