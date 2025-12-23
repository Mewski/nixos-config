{
  flake.homeModules.dunst =
    { theme, scheme, ... }:
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
      popupsOpacityHex = toHex theme.opacity.popups;
    in
    {
      services.dunst.settings = {
        global = {
          font = "${theme.fonts.sansSerif.name} ${toString theme.fonts.sizes.desktop}";
          frame_color = scheme.withHashtag.base0D;
          separator_color = "frame";
          highlight = scheme.withHashtag.base0D;
          progress_bar = true;
          progress_bar_height = 8;
          progress_bar_frame_width = 0;
          progress_bar_min_width = 150;
          progress_bar_max_width = 276;
          progress_bar_corner_radius = 4;
        };

        urgency_low = {
          background = "${scheme.withHashtag.base01}${popupsOpacityHex}";
          foreground = scheme.withHashtag.base04;
          frame_color = scheme.withHashtag.base03;
          highlight = scheme.withHashtag.base03;
        };

        urgency_normal = {
          background = "${scheme.withHashtag.base00}${popupsOpacityHex}";
          foreground = scheme.withHashtag.base05;
          frame_color = scheme.withHashtag.base0D;
          highlight = scheme.withHashtag.base0D;
        };

        urgency_critical = {
          background = "${scheme.withHashtag.base00}${popupsOpacityHex}";
          foreground = scheme.withHashtag.base08;
          frame_color = scheme.withHashtag.base08;
          highlight = scheme.withHashtag.base08;
        };
      };
    };
}
