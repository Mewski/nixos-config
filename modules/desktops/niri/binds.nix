{
  flake.homeModules.niri =
    { lib, pkgs, ... }:
    let
      notify = lib.getExe pkgs.libnotify;
      notifyOsd = "${lib.getExe' pkgs.coreutils "timeout"} 0.2s ${notify}";
      wpctl = lib.getExe' pkgs.wireplumber "wpctl";
      kitty = lib.getExe pkgs.kitty;
      rofi = lib.getExe pkgs.rofi;
      swaylock = lib.getExe pkgs.swaylock;
      bitwarden = lib.getExe pkgs.bitwarden-desktop;
      dolphin = lib.getExe pkgs.kdePackages.dolphin;
      btop = lib.getExe pkgs.btop;
      zed = lib.getExe pkgs.zed-editor;
      grim = lib.getExe pkgs.grim;
      slurp = lib.getExe pkgs.slurp;
      tesseract = lib.getExe pkgs.tesseract;
      satty = lib.getExe pkgs.satty;
      cliphist = lib.getExe pkgs.cliphist;
      wfrecorder = lib.getExe pkgs.wf-recorder;
      playerctl = lib.getExe pkgs.playerctl;
      wlcopy = lib.getExe' pkgs.wl-clipboard "wl-copy";
      systemctl = lib.getExe' pkgs.systemd "systemctl";

      spawn = command: { action.spawn = command; };
      spawnSh = command: { action.spawn-sh = command; };

      toggleWaybar = "${systemctl} --user kill -s SIGUSR1 waybar.service";
      getVolume = "${wpctl} get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}'";
      isMuted = sink: "${wpctl} get-volume ${sink} | grep -q MUTED";

      notifyVolume = pkgs.writeShellScript "notify-volume" ''
        ${notifyOsd} -a osd -t 1000 \
          -h string:x-dunst-stack-tag:volume \
          -h int:value:$(${getVolume}) \
          'System Volume'
      '';

      notifyVolumeMute = pkgs.writeShellScript "notify-volume-mute" ''
        if ${isMuted "@DEFAULT_AUDIO_SINK@"}; then
          ${notifyOsd} -a osd-text -t 1000 -h string:x-dunst-stack-tag:volume "System Volume Muted"
        else
          ${notifyOsd} -a osd-text -t 1000 -h string:x-dunst-stack-tag:volume "System Volume Unmuted"
        fi
      '';

      notifyMicMute = pkgs.writeShellScript "notify-mic-mute" ''
        if ${isMuted "@DEFAULT_AUDIO_SOURCE@"}; then
          ${notifyOsd} -a osd-text -t 1000 -h string:x-dunst-stack-tag:mic "Microphone Muted"
        else
          ${notifyOsd} -a osd-text -t 1000 -h string:x-dunst-stack-tag:mic "Microphone Unmuted"
        fi
      '';

      cliphistSelect = pkgs.writeShellScript "cliphist-select" ''
        selected=$(${cliphist} list | ${rofi} -dmenu -display-columns 2 -no-show-icons)
        if [ -n "$selected" ]; then
          printf '%s' "$selected" | ${cliphist} decode | ${wlcopy}
          ${notifyOsd} -a osd-text -t 1000 'Copied to clipboard'
        fi
      '';

      screenshot = pkgs.writeShellScript "screenshot" ''
        dir=~/Pictures/Screenshots
        mkdir -p "$dir"
        file="$dir/$(date +%Y-%m-%d-%H%M%S).png"
        case "$1" in
          region)
            geometry=$(${slurp}) || exit 0
            [ -n "$geometry" ] || exit 0
            ${grim} -g "$geometry" "$file" || { rm -f "$file"; exit 1; }
            ;;
          output) ${grim} "$file" || { rm -f "$file"; exit 1; } ;;
          *) ${grim} "$file" || { rm -f "$file"; exit 1; } ;;
        esac
        [ -s "$file" ] || exit 0
        ${wlcopy} < "$file"
        action=$(${notify} -a Screenshot -t 5000 -i "$file" -A "edit=Edit in Satty" "Screenshot saved" "Image saved in <i>$file</i> and copied to the clipboard.")
        if [ "$action" = "edit" ]; then
          ${satty} -f "$file"
        fi
      '';

      ocr = pkgs.writeShellScript "ocr" ''
        geometry=$(${slurp}) || exit 0
        [ -n "$geometry" ] || exit 0
        ${grim} -g "$geometry" - | ${tesseract} - - | ${wlcopy}
        ${notifyOsd} -a osd-text -t 1000 'Text copied to clipboard'
      '';

      screenRecord = pkgs.writeShellScript "screen-record" ''
        pidfile=/tmp/wf-recorder.pid
        if [ -f "$pidfile" ] && kill -0 "$(cat "$pidfile")" 2>/dev/null; then
          kill "$(cat "$pidfile")"
          rm -f "$pidfile"
          ${notifyOsd} -a osd-text -t 2000 'Recording stopped'
        else
          dir=~/Videos/Recordings
          mkdir -p "$dir"
          file="$dir/$(date +%Y-%m-%d-%H%M%S).mp4"
          ${wfrecorder} -f "$file" &
          echo $! > "$pidfile"
          ${notifyOsd} -a osd-text -t 2000 'Recording started'
        fi
      '';

      workspaceBinds = builtins.listToAttrs (
        builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = if i == 0 then 10 else i;
            in
            [
              {
                name = "Mod+${toString i}";
                value.action.focus-workspace = ws;
              }
              {
                name = "Mod+Shift+${toString i}";
                value.action.move-window-to-workspace = ws;
              }
            ]
          ) 10
        )
      );
    in
    {
      home.packages = [ pkgs.wf-recorder ];

      programs.niri.settings.binds = {
        "Mod+R" = spawn [
          rofi
          "-show"
          "drun"
        ];
        "Mod+Q" = spawn [ kitty ];
        "Mod+L" = spawn [
          swaylock
          "--daemonize"
        ];
        "Mod+U" = spawn [ bitwarden ];
        "Mod+E" = spawn [ dolphin ];
        "Mod+I" = spawn [
          kitty
          btop
        ];
        "Mod+K" = spawn [ "${cliphistSelect}" ];
        "Mod+Z" = spawn [ zed ];
        "Mod+D" = spawn [ "discord" ];
        "Mod+B" = spawn [ "zen-beta" ];
        "Mod+Shift+S" = spawn [
          "${screenshot}"
          "region"
        ];
        "Mod+Alt+S" = {
          action.screenshot-window = { };
        };
        "Mod+Ctrl+S" = spawn [
          "${screenshot}"
          "output"
        ];
        "Mod+O" = spawn [ "${ocr}" ];
        "Mod+Shift+R" = spawn [ "${screenRecord}" ];
        "Mod+T" = {
          action.toggle-window-rule-opacity = { };
        };
        "Mod+W" = spawnSh toggleWaybar;
        "Mod+C" = {
          action.close-window = { };
        };
        "Mod+F" = {
          action.fullscreen-window = { };
        };
        "Mod+V" = {
          action.toggle-window-floating = { };
        };
        "Mod+Shift+M" = {
          action.quit.skip-confirmation = false;
        };
        "Mod+Escape" = {
          action.toggle-keyboard-shortcuts-inhibit = { };
          allow-inhibiting = false;
        };
        "Mod+Up" = {
          action.focus-window-or-workspace-up = { };
        };
        "Mod+Down" = {
          action.focus-window-or-workspace-down = { };
        };
        "Mod+Left" = {
          action.focus-column-left = { };
        };
        "Mod+Right" = {
          action.focus-column-right = { };
        };
        "Mod+Shift+Up" = {
          action.move-window-up = { };
        };
        "Mod+Shift+Down" = {
          action.move-window-down = { };
        };
        "Mod+Shift+Left" = {
          action.move-column-left = { };
        };
        "Mod+Shift+Right" = {
          action.move-column-right = { };
        };
        "Mod+WheelScrollDown" = {
          action.focus-workspace-down = { };
          cooldown-ms = 150;
        };
        "Mod+WheelScrollUp" = {
          action.focus-workspace-up = { };
          cooldown-ms = 150;
        };
        "XF86AudioRaiseVolume" =
          spawnSh "${wpctl} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && ${notifyVolume}";
        "XF86AudioLowerVolume" = spawnSh "${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%- && ${notifyVolume}";
        "XF86AudioMute" = spawnSh "${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle && ${notifyVolumeMute}";
        "XF86AudioMicMute" = spawnSh "${wpctl} set-mute @DEFAULT_AUDIO_SOURCE@ toggle && ${notifyMicMute}";
        "XF86AudioPlay" = spawn [
          playerctl
          "play-pause"
        ];
        "XF86AudioPause" = spawn [
          playerctl
          "play-pause"
        ];
        "XF86AudioNext" = spawn [
          playerctl
          "next"
        ];
        "XF86AudioPrev" = spawn [
          playerctl
          "previous"
        ];
      }
      // workspaceBinds;
    };
}
