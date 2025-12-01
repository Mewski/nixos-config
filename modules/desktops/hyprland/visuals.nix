{
  flake.homeModules.hyprland = {
    wayland.windowManager.hyprland.settings = {
      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 0"
          "workspacesIn, 0"
          "workspacesOut, 0"
          "zoomFactor, 1, 7, quick"
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
          enabled = false;
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

      layerrule = [
        "blur, waybar"
        "ignorealpha 0.0, waybar"
        "blur, rofi"
        "ignorealpha 0.0, rofi"
        "blur, notifications"
        "ignorealpha 0.0, notifications"
      ];
    };
  };
}
