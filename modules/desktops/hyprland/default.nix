{
  flake.nixosModules.hyprland = {
    programs.hyprland.enable = true;
  };

  flake.homeModules.hyprland = {
    wayland.windowManager.hyprland.enable = true;
  };
}
