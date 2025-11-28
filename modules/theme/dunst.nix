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
          highlight = "#${scheme.base0D}";
          progress_bar = true;
          progress_bar_height = 8;
          progress_bar_frame_width = 0;
          progress_bar_min_width = 150;
          progress_bar_max_width = 276;
          progress_bar_corner_radius = 4;
        };

        urgency_low = {
          background = "#${scheme.base01}${opacityHex}";
          foreground = "#${scheme.base04}";
          frame_color = "#${scheme.base03}";
          highlight = "#${scheme.base03}";
        };

        urgency_normal = {
          background = "#${scheme.base00}${opacityHex}";
          foreground = "#${scheme.base05}";
          frame_color = "#${scheme.base0D}";
          highlight = "#${scheme.base0D}";
        };

        urgency_critical = {
          background = "#${scheme.base00}${opacityHex}";
          foreground = "#${scheme.base08}";
          frame_color = "#${scheme.base08}";
          highlight = "#${scheme.base08}";
        };
      };
    };
}
