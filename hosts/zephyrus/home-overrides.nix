{ lib, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # Display configuration
    monitor = lib.mkForce "eDP-1,preferred,0x0,1.25";

    # Key bindings that allow repeat when held down
    bindel = lib.mkForce [
      # Audio controls
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

      # Intel integrated graphics for brightness control
      ",XF86MonBrightnessUp, exec, brightnessctl -d intel_backlight -e4 -n2 set 5%+"
      ",XF86MonBrightnessDown, exec, brightnessctl -d intel_backlight -e4 -n2 set 5%-"

      # ASUS keyboard backlight device
      ",XF86KbdBrightnessUp, exec, brightnessctl -d asus::kbd_backlight set 1+"
      ",XF86KbdBrightnessDown, exec, brightnessctl -d asus::kbd_backlight set 1-"

      # Window resizing
      "$mainMod ALT, left, resizeactive, -40 0"
      "$mainMod ALT, right, resizeactive, 40 0"
      "$mainMod ALT, up, resizeactive, 0 -40"
      "$mainMod ALT, down, resizeactive, 0 40"
    ];
  };
}
