{
  flake.homeModules.hyprland =
    { pkgs, lib, ... }:
    {
      wayland.windowManager.hyprland.settings = {
        bind = [
          "SUPER, R, exec, ${lib.getExe pkgs.rofi} -show drun"
          "SUPER, Q, exec, ${lib.getExe pkgs.kitty}"
          "SUPER, L, exec, ${lib.getExe pkgs.hyprlock}"
          "SUPER, U, exec, ${lib.getExe pkgs.bitwarden-desktop}"
          "SUPER, E, exec, ${lib.getExe pkgs.kitty} ${lib.getExe pkgs.fish} -c ${lib.getExe pkgs.yazi}"
          "SUPER, I, exec, ${lib.getExe pkgs.kitty} ${lib.getExe pkgs.btop}"
          "SUPER, D, exec, discord"
          "SUPER, B, exec, zen"

          "SUPER SHIFT, S, exec, ${lib.getExe pkgs.hyprshot} -m region -z -o ~/Pictures/Screenshots"
          "SUPER ALT, S, exec, ${lib.getExe pkgs.hyprshot} -m window -z -o ~/Pictures/Screenshots"
          "SUPER CONTROL_L, S, exec, ${lib.getExe pkgs.hyprshot} -m output -z -o ~/Pictures/Screenshots"

          "SUPER, M, exit,"

          "SUPER, down, movefocus, d"
          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"

          "SUPER, C, killactive,"
          "SUPER, J, togglesplit,"
          "SUPER, P, pseudo,"
          "SUPER, V, togglefloating,"

          "SUPER SHIFT, down, swapwindow, d"
          "SUPER SHIFT, left, swapwindow, l"
          "SUPER SHIFT, right, swapwindow, r"
          "SUPER SHIFT, up, swapwindow, u"

          "SUPER, 0, workspace, 10"
          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER, 5, workspace, 5"
          "SUPER, 6, workspace, 6"
          "SUPER, 7, workspace, 7"
          "SUPER, 8, workspace, 8"
          "SUPER, 9, workspace, 9"

          "SUPER SHIFT, 0, movetoworkspace, 10"
          "SUPER SHIFT, 1, movetoworkspace, 1"
          "SUPER SHIFT, 2, movetoworkspace, 2"
          "SUPER SHIFT, 3, movetoworkspace, 3"
          "SUPER SHIFT, 4, movetoworkspace, 4"
          "SUPER SHIFT, 5, movetoworkspace, 5"
          "SUPER SHIFT, 6, movetoworkspace, 6"
          "SUPER SHIFT, 7, movetoworkspace, 7"
          "SUPER SHIFT, 8, movetoworkspace, 8"
          "SUPER SHIFT, 9, movetoworkspace, 9"

          "SUPER, mouse_down, workspace, e+1"
          "SUPER, mouse_up, workspace, e-1"
        ];

        bindel = [
          ",XF86AudioLowerVolume, exec, ${lib.getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_AUDIO_SINK@ 5%- && ${lib.getExe pkgs.libnotify} -a osd -t 1000 -h string:x-dunst-stack-tag:volume -h int:value:$(${lib.getExe' pkgs.wireplumber "wpctl"} get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}') 'System Volume'"
          ",XF86AudioMicMute, exec, ${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SOURCE@ toggle && ${lib.getExe pkgs.libnotify} -a osd -t 1000 -h string:x-dunst-stack-tag:mic \"Microphone $(${lib.getExe' pkgs.wireplumber "wpctl"} get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED && echo Muted || echo Unmuted)\""
          ",XF86AudioMute, exec, ${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SINK@ toggle && ${lib.getExe pkgs.libnotify} -a osd -t 1000 -h string:x-dunst-stack-tag:volume -h int:value:$(${lib.getExe' pkgs.wireplumber "wpctl"} get-volume @DEFAULT_AUDIO_SINK@ | awk '{if (/MUTED/) print 0; else print int($2*100)}') 'System Volume'"
          ",XF86AudioRaiseVolume, exec, ${lib.getExe' pkgs.wireplumber "wpctl"} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && ${lib.getExe pkgs.libnotify} -a osd -t 1000 -h string:x-dunst-stack-tag:volume -h int:value:$(${lib.getExe' pkgs.wireplumber "wpctl"} get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}') 'System Volume'"

          "SUPER ALT, down, resizeactive, 0 40"
          "SUPER ALT, left, resizeactive, -40 0"
          "SUPER ALT, right, resizeactive, 40 0"
          "SUPER ALT, up, resizeactive, 0 -40"
        ];

        bindl = [
          ",XF86AudioNext, exec, ${lib.getExe pkgs.playerctl} next"
          ",XF86AudioPause, exec, ${lib.getExe pkgs.playerctl} play-pause"
          ",XF86AudioPlay, exec, ${lib.getExe pkgs.playerctl} play-pause"
          ",XF86AudioPrev, exec, ${lib.getExe pkgs.playerctl} previous"
        ];

        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];
      };
    };
}
