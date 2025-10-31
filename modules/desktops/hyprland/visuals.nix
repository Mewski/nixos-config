{
  flake.homeModules.hyprland = {
    wayland.windowManager.hyprland.settings = {
      animations = {
        enabled = true;

        bezier = [
          "almostLinear,0.5,0.5,0.75,1.0"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "easeOutQuint,0.23,1,0.32,1"
          "linear,0,0,1,1"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "border, 1, 3.5, easeOutQuint"
          "fade, 1, 2, quick"
          "fadeIn, 1, 1.2, almostLinear"
          "fadeLayersIn, 1, 1.3, almostLinear"
          "fadeLayersOut, 1, 1, almostLinear"
          "fadeOut, 1, 1, almostLinear"
          "global, 1, 6, default"
          "layers, 1, 2.5, easeOutQuint"
          "layersIn, 1, 2.8, easeOutQuint, fade"
          "layersOut, 1, 1.2, linear, fade"
          "windows, 1, 3.2, easeOutQuint"
          "windowsIn, 1, 2.8, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.2, linear, popin 87%"
          "workspaces, 1, 1.3, almostLinear, fade"
          "workspacesIn, 1, 0.9, almostLinear, fade"
          "workspacesOut, 1, 1.3, almostLinear, fade"
          "zoomFactor, 1, 4.5, quick"
        ];
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;

        blur = {
          enabled = true;
          new_optimizations = true;
          passes = 5;
          popups = true;
          size = 5;
          vibrancy = 0.1696;
        };

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };
      };

      general = {
        allow_tearing = true;
        resize_on_border = false;

        border_size = 2;

        gaps_in = 4;
        gaps_out = 8;
      };
    };
  };
}
