{
  flake.homeModules.hyprland =
    { scheme, ... }:
    {
      wayland.windowManager.hyprland.settings = {
        decoration.shadow.color = "rgba(${scheme.base00}99)";

        general = {
          "col.active_border" = "rgb(${scheme.base0D})";
          "col.inactive_border" = "rgb(${scheme.base03})";
        };
      };
    };
}
