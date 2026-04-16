{
  flake.homeModules.hyprland =
    {
      lib,
      osConfig,
      theme,
      ...
    }:
    let
      scale = lib.strings.floatToString theme.scale;
    in
    lib.mkIf (osConfig.networking.hostName == "crosshair") {
      wayland.windowManager.hyprland.settings.monitor = [
        "DP-3, 3840x2160@240, 0x0, ${scale}, vrr, 0, bitdepth, 10"
        ", preferred, auto, ${scale}"
      ];
    };
}
