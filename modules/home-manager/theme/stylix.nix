{ ... }:

{
  # Stylix opacity
  stylix.opacity = {
    applications = 1.0;
    terminal = 0.8;
    desktop = 1.0;
    popups = 1.0;
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
