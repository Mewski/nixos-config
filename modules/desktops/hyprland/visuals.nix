{
  flake.homeModules.hyprland = {
    wayland.windowManager.hyprland.settings = {
      general = {
        border_size = 2;
        gaps_in = 3;
        gaps_out = 6;
        resize_on_border = false;
        allow_tearing = true;
      };

      decoration = {
        rounding = 8;
        rounding_power = 2;

        blur = {
          enabled = true;
          size = 5;
          passes = 5;
          popups = true;
          new_optimizations = true;
          vibrancy = 0.1696;
        };

        shadow = {
          enabled = false;
          range = 4;
          render_power = 3;
        };
      };

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
          "layersIn, 1, 3, easeOutQuint, fade"
          "layersOut, 1, 3, easeOutQuint, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 3.8, easeOutQuint, slide"
          "specialWorkspace, 1, 3, easeOutQuint, slidevert"
          "zoomFactor, 1, 2, quick"
        ];
      };

      misc.disable_hyprland_logo = true;

      layerrule = [
        "blur on, match:namespace waybar"
        "ignore_alpha 0.1, match:namespace waybar"
        "blur on, match:namespace rofi"
        "ignore_alpha 0.1, match:namespace rofi"
        "animation slidefade top, match:namespace rofi"
        "blur on, match:namespace notifications"
        "ignore_alpha 0.1, match:namespace notifications"
      ];
    };
  };
}
