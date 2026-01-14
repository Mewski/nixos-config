{
  flake.homeModules.hyprland =
    { lib, pkgs, ... }:
    let
      wpctl = lib.getExe' pkgs.wireplumber "wpctl";
      notify = lib.getExe pkgs.libnotify;

      getVolume = "${wpctl} get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}'";
      isMuted = sink: "${wpctl} get-volume ${sink} | grep -q MUTED";

      notifyVolume = pkgs.writeShellScript "notify-volume" ''
        ${notify} -a osd -t 1000 \
          -h string:x-dunst-stack-tag:volume \
          -h int:value:$(${getVolume}) \
          'System Volume'
      '';

      notifyVolumeMute = pkgs.writeShellScript "notify-volume-mute" ''
        if ${isMuted "@DEFAULT_AUDIO_SINK@"}; then
          ${notify} -a osd-text -t 1000 -h string:x-dunst-stack-tag:volume "System Volume Muted"
        else
          ${notify} -a osd-text -t 1000 -h string:x-dunst-stack-tag:volume "System Volume Unmuted"
        fi
      '';

      notifyMicMute = pkgs.writeShellScript "notify-mic-mute" ''
        if ${isMuted "@DEFAULT_AUDIO_SOURCE@"}; then
          ${notify} -a osd-text -t 1000 -h string:x-dunst-stack-tag:mic "Microphone Muted"
        else
          ${notify} -a osd-text -t 1000 -h string:x-dunst-stack-tag:mic "Microphone Unmuted"
        fi
      '';

      cliphistSelect = pkgs.writeShellScript "cliphist-select" ''
        selected=$(${lib.getExe pkgs.cliphist} list | ${lib.getExe pkgs.rofi} -dmenu -display-columns 2 -no-show-icons)
        if [ -n "$selected" ]; then
          echo "$selected" | ${lib.getExe pkgs.cliphist} decode | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}
          ${notify} -a osd-text -t 1000 'Copied to clipboard'
        fi
      '';

      ocr = pkgs.writeShellScript "ocr" ''
        ${lib.getExe pkgs.hyprshot} -m region -z --raw | ${lib.getExe pkgs.tesseract} - - | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}
        ${notify} -a osd-text -t 1000 'Text copied to clipboard'
      '';

      workspaceBinds = builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = if i == 0 then 10 else i;
          in
          [
            "SUPER, ${toString i}, workspace, ${toString ws}"
            "SUPER SHIFT, ${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 10
      );
    in
    {
      wayland.windowManager.hyprland.settings = {
        bind = [
          "SUPER, R, exec, ${lib.getExe pkgs.rofi} -show drun"
          "SUPER, Q, exec, ${lib.getExe pkgs.kitty}"
          "SUPER, L, exec, ${lib.getExe pkgs.hyprlock} --immediate-render"
          "SUPER, U, exec, ${lib.getExe pkgs.bitwarden-desktop}"
          "SUPER, E, exec, ${lib.getExe pkgs.nautilus}"
          "SUPER, I, exec, ${lib.getExe pkgs.kitty} ${lib.getExe pkgs.btop}"
          "SUPER, K, exec, ${cliphistSelect}"
          "SUPER, Z, exec, ${lib.getExe pkgs.zed-editor}"
          "SUPER, D, exec, discord"
          "SUPER, B, exec, zen"

          "SUPER, S, exec, ${lib.getExe pkgs.hyprpicker} -a -r"
          "SUPER SHIFT, S, exec, ${lib.getExe pkgs.hyprshot} -m region -z -o ~/Pictures/Screenshots"
          "SUPER ALT, S, exec, ${lib.getExe pkgs.hyprshot} -m window -z -o ~/Pictures/Screenshots"
          "SUPER CONTROL_L, S, exec, ${lib.getExe pkgs.hyprshot} -m output -z -o ~/Pictures/Screenshots"
          "SUPER, O, exec, ${ocr}"

          "SUPER, C, killactive,"
          "SUPER, F, fullscreen"
          "SUPER, J, togglesplit,"
          "SUPER SHIFT, M, exit,"
          "SUPER, P, pseudo,"
          "SUPER, V, togglefloating,"

          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"
          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"

          "SUPER SHIFT, up, swapwindow, u"
          "SUPER SHIFT, down, swapwindow, d"
          "SUPER SHIFT, left, swapwindow, l"
          "SUPER SHIFT, right, swapwindow, r"

          "SUPER, mouse_up, workspace, e+1"
          "SUPER, mouse_down, workspace, e-1"

          "SUPER, grave, togglespecialworkspace,"
          "SUPER SHIFT, grave, movetoworkspace, special"
        ]
        ++ workspaceBinds;

        bindel = [
          ",XF86AudioRaiseVolume, exec, ${wpctl} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && ${notifyVolume}"
          ",XF86AudioLowerVolume, exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%- && ${notifyVolume}"
          ",XF86AudioMute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle && ${notifyVolumeMute}"
          ",XF86AudioMicMute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SOURCE@ toggle && ${notifyMicMute}"

          "SUPER ALT, up, resizeactive, 0 -40"
          "SUPER ALT, down, resizeactive, 0 40"
          "SUPER ALT, left, resizeactive, -40 0"
          "SUPER ALT, right, resizeactive, 40 0"
        ];

        bindl = [
          ",XF86AudioPlay, exec, ${lib.getExe pkgs.playerctl} play-pause"
          ",XF86AudioPause, exec, ${lib.getExe pkgs.playerctl} play-pause"
          ",XF86AudioNext, exec, ${lib.getExe pkgs.playerctl} next"
          ",XF86AudioPrev, exec, ${lib.getExe pkgs.playerctl} previous"
        ];

        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];
      };
    };
}
