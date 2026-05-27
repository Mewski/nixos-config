{
  flake.homeModules.niri =
    { theme, ... }:
    {
      programs.niri.settings = {
        layout = {
          center-focused-column = "never";
          always-center-single-column = false;
          default-column-width.proportion = 0.5;
          preset-column-widths = [
            { proportion = 0.33333; }
            { proportion = 0.5; }
            { proportion = 0.66667; }
            { proportion = 1.0; }
          ];
          preset-window-heights = [
            { proportion = 0.33333; }
            { proportion = 0.5; }
            { proportion = 0.66667; }
          ];
        };

        window-rules = [
          {
            geometry-corner-radius = {
              top-left = theme.rounding * 1.0;
              top-right = theme.rounding * 1.0;
              bottom-right = theme.rounding * 1.0;
              bottom-left = theme.rounding * 1.0;
            };
            clip-to-geometry = true;
            draw-border-with-background = false;
          }
          {
            matches = [ { app-id = "kitty"; } ];
            opacity = 1.0;
          }
          {
            matches = [
              { app-id = "^dev\\.zed\\.Zed$"; }
              { app-id = "^discord$"; }
              { app-id = "^Discord$"; }
              { app-id = "^vesktop$"; }
              { app-id = "^Vesktop$"; }
              { app-id = "^zen$"; }
              { app-id = "^zen-beta$"; }
              { app-id = "^obsidian$"; }
              { app-id = "^signal$"; }
              { app-id = "^signal-desktop$"; }
              { app-id = "^spotify$"; }
              { app-id = "^bitwarden$"; }
              { app-id = "^Bitwarden$"; }
              { app-id = "^wootility$"; }
              { app-id = "^Wootility$"; }
            ];
            tiled-state = true;
          }
          {
            matches = [
              { title = "^(Open|Save|File|Folder|Browse|Choose|Select|Export|Import|Upload|Download).*"; }
            ];
            open-floating = true;
            default-column-width.fixed = 900;
            default-window-height.fixed = 500;
          }
        ];
      };
    };
}
