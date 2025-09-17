{ lib, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # Display configuration for ASUS Zephyrus G16 2560x1600@240Hz
    monitor = lib.mkForce "eDP-1, 2560x1600@240, 0x0, 1.25";

    # NVIDIA and Wayland environment variables
    env = [
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "__NV_PRIME_RENDER_OFFLOAD,1"
      "ELECTRON_OZONE_PLATFORM_HINT,auto"
      "LIBVA_DRIVER_NAME,nvidia"
      "NVD_BACKEND,direct"
    ];

    # Key bindings that allow repeat when held down
    bindel = lib.mkForce [
      # Audio controls
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"

      # ASUS keyboard backlight controls
      ",XF86KbdBrightnessDown, exec, brightnessctl -d asus::kbd_backlight set 1-"
      ",XF86KbdBrightnessUp, exec, brightnessctl -d asus::kbd_backlight set 1+"

      # Intel integrated graphics brightness controls
      ",XF86MonBrightnessDown, exec, brightnessctl -d intel_backlight -e4 -n2 set 5%-"
      ",XF86MonBrightnessUp, exec, brightnessctl -d intel_backlight -e4 -n2 set 5%+"

      # Window resizing
      "$mainMod CONTROL_L, down, resizeactive, 0 40"
      "$mainMod CONTROL_L, left, resizeactive, -40 0"
      "$mainMod CONTROL_L, right, resizeactive, 40 0"
      "$mainMod CONTROL_L, up, resizeactive, 0 -40"
    ];
  };
}
