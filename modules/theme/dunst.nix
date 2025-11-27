{
  flake.homeModules.theme =
    {
      scheme,
      fonts,
      opacity,
      ...
    }:
    let
      toHex =
        f:
        let
          hex = "0123456789abcdef";
          i = builtins.floor (f * 255);
          hi = i / 16;
          lo = i - hi * 16;
        in
        builtins.substring hi 1 hex + builtins.substring lo 1 hex;
      opacityHex = toHex opacity.desktop;
    in
    {
      services.dunst.settings = {
        global = {
          font = "${fonts.sansSerif.name} ${toString fonts.sizes.desktop}";
          frame_color = "#${scheme.base0D}";
          separator_color = "frame";
        };

        urgency_low = {
          background = "#${scheme.base01}${opacityHex}";
          foreground = "#${scheme.base04}";
          frame_color = "#${scheme.base03}";
        };

        urgency_normal = {
          background = "#${scheme.base00}${opacityHex}";
          foreground = "#${scheme.base05}";
          frame_color = "#${scheme.base0D}";
        };

        urgency_critical = {
          background = "#${scheme.base00}${opacityHex}";
          foreground = "#${scheme.base08}";
          frame_color = "#${scheme.base08}";
        };
      };
    };
}
