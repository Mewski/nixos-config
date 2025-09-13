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
    enable = true;
    variant256Colors = true;
  };

  # Btop
  stylix.targets.btop.enable = true;

  # Hyprland
  stylix.targets.hyprland.enable = true;
  stylix.targets.hyprland.hyprpaper.enable = true;

  # Zen Browser
  stylix.targets.zen-browser = {
    enable = true;
    profileNames = [ "default" ];
  };
}
