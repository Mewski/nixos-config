{
  flake.homeModules.theme =
    {
      config,
      scheme,
      opacity,
      fonts,
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
            text-color = mkLiteral "#${scheme.base05}";
            font = "${fonts.sansSerif.name} ${toString fonts.sizes.desktop}";
          };

          window = {
            background-color = mkLiteral "rgba(${scheme.base00-rgb-r}, ${scheme.base00-rgb-g}, ${scheme.base00-rgb-b}, ${toString opacity.desktop})";
            border = mkLiteral "2px";
            border-color = mkLiteral "#${scheme.base0D}";
            border-radius = mkLiteral "10px";
            padding = mkLiteral "8px";
          };

          mainbox = {
            background-color = mkLiteral "transparent";
            spacing = mkLiteral "8px";
          };

          inputbar = {
            background-color = mkLiteral "rgba(${scheme.base01-rgb-r}, ${scheme.base01-rgb-g}, ${scheme.base01-rgb-b}, ${
              toString (opacity.desktop * 0.5)
            })";
            border-radius = mkLiteral "4px";
            padding = mkLiteral "8px";
            children = mkLiteral "[entry]";
          };

          entry = {
            placeholder = "Search...";
            placeholder-color = mkLiteral "#${scheme.base03}";
          };

          listview = {
            spacing = mkLiteral "4px";
            scrollbar = mkLiteral "false";
            lines = mkLiteral "8";
          };

          element = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "#${scheme.base05}";
            border-radius = mkLiteral "4px";
            padding = mkLiteral "8px";
            spacing = mkLiteral "8px";
          };

          "element selected" = {
            background-color = mkLiteral "#${scheme.base0D}";
            text-color = mkLiteral "#${scheme.base00}";
          };

          "element alternate" = {
            background-color = mkLiteral "transparent";
          };

          "element-text" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
            vertical-align = mkLiteral "0.5";
            font = "${fonts.sansSerif.name} ${toString fonts.sizes.desktop}";
          };

          "element-icon" = {
            background-color = mkLiteral "transparent";
            size = mkLiteral "1.2em";
            vertical-align = mkLiteral "0.5";
          };
        };
    };
}
