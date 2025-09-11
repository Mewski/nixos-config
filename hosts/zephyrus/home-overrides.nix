{ ... }:

{
  # Host-specific Home Manager configuration

  # Hyprland media key bindings optimized for this hardware
  wayland.windowManager.hyprland.settings = {
    monitor = "eDP-1,auto,0x0,1.25";

    bindel = [
      # Volume controls
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

      # Brightness controls optimized for Zephyrus hybrid NVIDIA/Intel graphics
      ",XF86MonBrightnessUp, exec, brightnessctl -d intel_backlight -e4 -n2 set 5%+"
      ",XF86MonBrightnessDown, exec, brightnessctl -d intel_backlight -e4 -n2 set 5%-"

      # Keyboard backlight brightness controls
      ",XF86KbdBrightnessUp, exec, brightnessctl -d asus::kbd_backlight set 1+"
      ",XF86KbdBrightnessDown, exec, brightnessctl -d asus::kbd_backlight set 1-"
    ];

    bindl = [
      # Media player controls
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
  };
}
