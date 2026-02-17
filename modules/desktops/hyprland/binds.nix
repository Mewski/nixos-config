{
  flake.homeModules.hyprland =
    { lib, pkgs, ... }:
    let
      hyprctl = lib.getExe' pkgs.hyprland "hyprctl";
      jq = lib.getExe pkgs.jq;
      notify = lib.getExe pkgs.libnotify;
      wpctl = lib.getExe' pkgs.wireplumber "wpctl";

      getVolume = "${wpctl} get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}'";
      isMuted = sink: "${wpctl} get-volume ${sink} | grep -q MUTED";

      zoomIn = "${hyprctl} -q keyword cursor:zoom_factor $(${hyprctl} getoption cursor:zoom_factor -j | ${jq} '.float * 1.2')";
      zoomOut = "${hyprctl} -q keyword cursor:zoom_factor $(${hyprctl} getoption cursor:zoom_factor -j | ${jq} '(.float / 1.2) | if . < 1 then 1 else . end')";
      zoomReset = "${hyprctl} -q keyword cursor:zoom_factor 1";

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

      screenshot = pkgs.writeShellScript "screenshot" ''
        dir=~/Pictures/Screenshots
        mkdir -p "$dir"
        file="$dir/$(date +%Y-%m-%d-%H%M%S).png"

        if ! ${lib.getExe pkgs.hyprshot} -m "$1" -z -s -o "$dir" -f "$(basename "$file")"; then
          exit 0
        fi

        for _ in $(seq 1 10); do
          [ -f "$file" ] && break
          sleep 0.1
        done

        if [ ! -f "$file" ]; then
          exit 0
        fi

        action=$(${notify} -a Hyprshot -t 5000 -i "$file" \
          -A "edit=Edit in Satty" \
          "Screenshot saved" \
          "Image saved in <i>$file</i> and copied to the clipboard.")

        if [ "$action" = "edit" ]; then
          ${lib.getExe pkgs.satty} -f "$file"
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
        binds.scroll_event_delay = 0;

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
          "SUPER, B, exec, zen-beta"

          "SUPER, S, exec, ${lib.getExe pkgs.hyprpicker} -a -r"
          "SUPER SHIFT, S, exec, ${screenshot} region"
          "SUPER ALT, S, exec, ${screenshot} window"
          "SUPER CONTROL_L, S, exec, ${screenshot} output"
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

          "SUPER SHIFT, mouse:274, exec, ${zoomReset}"
        ]
        ++ workspaceBinds;

        binde = [
          "SUPER, equal, exec, ${zoomIn}"
          "SUPER, minus, exec, ${zoomOut}"
          "SUPER SHIFT, mouse_down, exec, ${zoomIn}"
          "SUPER SHIFT, mouse_up, exec, ${zoomOut}"
        ];

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
