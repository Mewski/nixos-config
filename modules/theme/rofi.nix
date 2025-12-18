{
  flake.homeModules.theme =
    {
      config,
      theme,
      scheme,
      ...
    }:
    {
      programs.rofi.theme =
        let
          mkLiteral = config.lib.formats.rasi.mkLiteral;
        in
        {
          "*" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "${scheme.withHashtag.base05}";
            font = "${theme.fonts.sansSerif.name} ${toString theme.fonts.sizes.desktop}";
          };

          window = {
            background-color = mkLiteral "rgba(${scheme.base00-rgb-r}, ${scheme.base00-rgb-g}, ${scheme.base00-rgb-b}, ${toString theme.opacity.desktop})";
            border = mkLiteral "2px";
            border-color = mkLiteral "${scheme.withHashtag.base0D}";
            border-radius = mkLiteral "8px";
            padding = mkLiteral "8px";
            width = mkLiteral "700px";
          };

          mainbox = {
            background-color = mkLiteral "transparent";
            spacing = mkLiteral "8px";
          };

          inputbar = {
            background-color = mkLiteral "rgba(${scheme.base01-rgb-r}, ${scheme.base01-rgb-g}, ${scheme.base01-rgb-b}, ${
              toString (theme.opacity.desktop * 0.8)
            })";
            border-radius = mkLiteral "6px";
            padding = mkLiteral "8px";
            children = mkLiteral "[entry]";
          };

          entry = {
            placeholder = "Search...";
            placeholder-color = mkLiteral "${scheme.withHashtag.base03}";
            font = "${theme.fonts.sansSerif.name} ${toString (theme.fonts.sizes.desktop * 3.0 / 2.5)}";
          };

          listview = {
            spacing = mkLiteral "4px";
            scrollbar = mkLiteral "false";
            lines = mkLiteral "8";
            columns = mkLiteral "2";
          };

          element = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "${scheme.withHashtag.base05}";
            border-radius = mkLiteral "6px";
            padding = mkLiteral "8px";
            spacing = mkLiteral "8px";
          };

          "element selected" = {
            background-color = mkLiteral "${scheme.withHashtag.base0D}";
            text-color = mkLiteral "${scheme.withHashtag.base00}";
          };

          "element alternate" = {
            background-color = mkLiteral "transparent";
          };

          "element-text" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
            vertical-align = mkLiteral "0.5";
            font = "${theme.fonts.sansSerif.name} ${toString theme.fonts.sizes.desktop}";
          };

          "element-icon" = {
            background-color = mkLiteral "transparent";
            size = mkLiteral "1.2em";
            vertical-align = mkLiteral "0.5";
          };
        };
    };
}
