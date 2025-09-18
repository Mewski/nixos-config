{ ... }:

{
  # Hyprland window manager configuration
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # Display configuration
      monitor = ", preferred, auto, 1";

      # Main modifier key
      "$mainMod" = "SUPER";

      # Default applications
      "$browser" = "zen";
      "$discord" = "discord";
      "$menu" = "fuzzel";
      "$terminal" = "kitty";

      # Autostart applications
      exec-once = [
        "waybar"
      ];

      # Environment variables for compatibility
      env = [
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
      ];

      # Animation configuration
      animations = {
        enabled = true;

        # Animation curves
        bezier = [
          "almostLinear,0.5,0.5,0.75,1.0"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "easeOutQuint,0.23,1,0.32,1"
          "linear,0,0,1,1"
          "quick,0.15,0,0.1,1"
        ];

        # Animation definitions
        animation = [
          "border, 1, 5.39, easeOutQuint"
          "fade, 1, 3.03, quick"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "global, 1, 10, default"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
          "zoomFactor, 1, 7, quick"
        ];
      };

      # Visual decoration settings
      decoration = {
        # Corner rounding
        rounding = 10;
        rounding_power = 2;

        # Background blur effects
        blur = {
          enabled = true;
          new_optimizations = true;
          passes = 4;
          popups = true;
          size = 8;
          vibrancy = 0.1696;
        };

        # Drop shadow configuration
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };
      };

      # Dwindle layout settings
      dwindle = {
        preserve_split = true;
        pseudotile = true;
      };

      # General window manager settings
      general = {
        # Window behavior
        allow_tearing = false;
        layout = "dwindle";
        resize_on_border = false;

        # Border configuration
        border_size = 2;

        # Gap sizes in pixels
        gaps_in = 5;
        gaps_out = 10;
      };

      # Gesture settings
      gesture = [
        "3, horizontal, workspace"
      ];

      # Input device configuration
      input = {
        # Mouse settings
        accel_profile = "flat";
        follow_mouse = 1;
        sensitivity = 0;

        # Keyboard layout
        kb_layout = "us";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        kb_variant = "";

        # Touchpad configuration
        touchpad = {
          clickfinger_behavior = true;
          disable_while_typing = false;
          natural_scroll = true;
          scroll_factor = 0.5;
        };
      };

      # Master layout settings
      master = {
        new_status = "master";
      };

      # Key bindings
      bind = [
        # Application shortcuts
        "$mainMod, B, exec, $browser"
        "$mainMod, D, exec, $discord"
        "$mainMod, Q, exec, $terminal"
        "$mainMod, R, exec, $menu"

        # Focus movement
        "$mainMod, down, movefocus, d"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"

        # Window management
        "$mainMod, C, killactive,"
        "$mainMod, J, togglesplit,"
        "$mainMod, M, exit,"
        "$mainMod, P, pseudo,"
        "$mainMod, V, togglefloating,"

        # Window swapping
        "$mainMod SHIFT, down, swapwindow, d"
        "$mainMod SHIFT, left, swapwindow, l"
        "$mainMod SHIFT, right, swapwindow, r"
        "$mainMod SHIFT, up, swapwindow, u"

        # Workspace switching
        "$mainMod, 0, workspace, 10"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"

        # Move windows to workspaces
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"

        # Special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Mouse wheel workspace switching
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      # Key bindings that allow repeat when held down
      bindel = [
        # Audio controls
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"

        # Screen brightness control
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"

        # Window resizing
        "$mainMod CONTROL_L, down, resizeactive, 0 40"
        "$mainMod CONTROL_L, left, resizeactive, -40 0"
        "$mainMod CONTROL_L, right, resizeactive, 40 0"
        "$mainMod CONTROL_L, up, resizeactive, 0 -40"
      ];

      # Key bindings for lock screen compatibility
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Window rules
      windowrule = [
        # Ignore empty XWayland windows
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        # Suppress maximize events for all windows
        "suppressevent maximize, class:.*"
      ];

      # Layer rules
      layerrule = [
        # Blur fuzzel application launcher
        "blur, launcher"

        # Blur waybar
        "blur, waybar"
      ];
    };
  };
}
