{
  flake.homeModules.hyprland =
    { lib, pkgs, ... }:
    let
      hyprctl = lib.getExe' pkgs.hyprland "hyprctl";
      jq = lib.getExe pkgs.jq;
      notify = lib.getExe pkgs.libnotify;
      wpctl = lib.getExe' pkgs.wireplumber "wpctl";
      kitty = lib.getExe pkgs.kitty;
      rofi = lib.getExe pkgs.rofi;
      hyprlock = lib.getExe pkgs.hyprlock;
      bitwarden = lib.getExe pkgs.bitwarden-desktop;
      nautilus = lib.getExe pkgs.nautilus;
      btop = lib.getExe pkgs.btop;
      zed = lib.getExe pkgs.zed-editor;
      hyprpicker = lib.getExe pkgs.hyprpicker;
      hyprshot = lib.getExe pkgs.hyprshot;
      tesseract = lib.getExe pkgs.tesseract;
      satty = lib.getExe pkgs.satty;
      cliphist = lib.getExe pkgs.cliphist;
      wfrecorder = lib.getExe pkgs.wf-recorder;
      playerctl = lib.getExe pkgs.playerctl;
      wlcopy = lib.getExe' pkgs.wl-clipboard "wl-copy";

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
        selected=$(${cliphist} list | ${rofi} -dmenu -display-columns 2 -no-show-icons)
        if [ -n "$selected" ]; then
          echo "$selected" | ${cliphist} decode | ${wlcopy}
          ${notify} -a osd-text -t 1000 'Copied to clipboard'
        fi
      '';

      screenshot = pkgs.writeShellScript "screenshot" ''
        dir=~/Pictures/Screenshots
        mkdir -p "$dir"
        file="$dir/$(date +%Y-%m-%d-%H%M%S).png"

        if ! ${hyprshot} -m "$1" -z -s -o "$dir" -f "$(basename "$file")"; then
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
          ${satty} -f "$file"
        fi
      '';

      ocr = pkgs.writeShellScript "ocr" ''
        ${hyprshot} -m region -z --raw | ${tesseract} - - | ${wlcopy}
        ${notify} -a osd-text -t 1000 'Text copied to clipboard'
      '';

      screenRecord = pkgs.writeShellScript "screen-record" ''
        pidfile=/tmp/wf-recorder.pid
        if [ -f "$pidfile" ] && kill -0 "$(cat "$pidfile")" 2>/dev/null; then
          kill "$(cat "$pidfile")"
          rm -f "$pidfile"
          ${notify} -a osd-text -t 2000 'Recording stopped'
        else
          dir=~/Videos/Recordings
          mkdir -p "$dir"
          file="$dir/$(date +%Y-%m-%d-%H%M%S).mp4"
          ${wfrecorder} -f "$file" &
          echo $! > "$pidfile"
          ${notify} -a osd-text -t 2000 'Recording started'
        fi
      '';

      workspaceBinds = builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = if i == 0 then 10 else i;
          in
          [
            "SUPER, ${toString i}, split-workspace, ${toString ws}"
            "SUPER SHIFT, ${toString i}, split-movetoworkspace, ${toString ws}"
          ]
        ) 10
      );
    in
    {
      wayland.windowManager.hyprland.settings = {
        binds.scroll_event_delay = 0;

        bind = [
          "SUPER, R, exec, ${rofi} -show drun"
          "SUPER, Q, exec, ${kitty}"
          "SUPER, L, exec, ${hyprlock} --immediate-render"
          "SUPER, U, exec, ${bitwarden}"
          "SUPER, E, exec, ${nautilus}"
          "SUPER, I, exec, ${kitty} ${btop}"
          "SUPER, K, exec, ${cliphistSelect}"
          "SUPER, Z, exec, ${zed}"
          "SUPER, D, exec, discord"
          "SUPER, B, exec, zen-beta"

          "SUPER, S, exec, ${hyprpicker} -a -r"
          "SUPER SHIFT, S, exec, ${screenshot} region"
          "SUPER ALT, S, exec, ${screenshot} window"
          "SUPER CONTROL_L, S, exec, ${screenshot} output"
          "SUPER, O, exec, ${ocr}"
          "SUPER SHIFT, R, exec, ${screenRecord}"

          "SUPER, T, togglespecialworkspace, scratchterm"
          "SUPER, M, togglespecialworkspace, scratchmusic"

          "SUPER, C, killactive,"
          "SUPER, F, fullscreen"
          "SUPER, J, layoutmsg, togglesplit"
          "SUPER SHIFT, M, exit,"
          "SUPER, P, pseudo, active"
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
          ",XF86AudioPlay, exec, ${playerctl} play-pause"
          ",XF86AudioPause, exec, ${playerctl} play-pause"
          ",XF86AudioNext, exec, ${playerctl} next"
          ",XF86AudioPrev, exec, ${playerctl} previous"
        ];

        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];
      };
    };
}
