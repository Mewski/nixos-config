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
              {
                name = "Mod+Ctrl+${toString i}";
                value.action.move-column-to-workspace = ws;
              }
            ]
          ) 10
        )
      );
    in
    {
      home.packages = [ pkgs.wf-recorder ];

      programs.niri.settings.binds = {
        "Mod+Space" = spawn [
          rofi
          "-show"
          "drun"
        ];
        "Mod+Return" = spawn [ kitty ];
        "Mod+Alt+L" = spawn [
          swaylock
          "--daemonize"
        ];
        "Mod+U" = spawn [ bitwarden ];
        "Mod+E" = spawn [ dolphin ];
        "Mod+I" = spawn [
          kitty
          btop
        ];
        "Mod+Alt+K" = spawn [ "${cliphistSelect}" ];
        "Mod+Z" = spawn [ zed ];
        "Mod+D" = spawn [ "discord" ];
        "Mod+B" = spawn [ "zen-beta" ];
        "Mod+Shift+S" = {
          action.screenshot = { };
        };
        "Mod+Alt+S" = {
          action.screenshot-window = { };
        };
        "Mod+Ctrl+S" = {
          action.screenshot-screen = { };
        };
        "Mod+Alt+O" = spawn [ "${ocr}" ];
        "Mod+Alt+Print" = spawn [ "${screenRecord}" ];
        "Mod+R" = {
          action.switch-preset-column-width = { };
        };
        "Mod+Shift+R" = {
          action.switch-preset-column-width-back = { };
        };
        "Mod+Ctrl+Shift+R" = {
          action.switch-preset-window-height = { };
        };
        "Mod+Ctrl+R" = {
          action.reset-window-height = { };
        };
        "Mod+Alt+T" = {
          action.toggle-window-rule-opacity = { };
        };
        "Mod+Alt+W" = spawnSh toggleWaybar;
        "Mod+Shift+Slash" = {
          action.show-hotkey-overlay = { };
        };
        "Mod+C" = {
          action.center-column = { };
        };
        "Mod+F" = {
          action.maximize-column = { };
        };
        "Mod+Shift+F" = {
          action.fullscreen-window = { };
        };
        "Mod+M" = {
          action.maximize-window-to-edges = { };
        };
        "Mod+Ctrl+F" = {
          action.expand-column-to-available-width = { };
        };
        "Mod+Ctrl+C" = {
          action.center-visible-columns = { };
        };
        "Mod+V" = {
          action.toggle-window-floating = { };
        };
        "Mod+Shift+V" = {
          action.switch-focus-between-floating-and-tiling = { };
        };
        "Mod+W" = {
          action.toggle-column-tabbed-display = { };
        };
        "Mod+Escape" = {
          action.toggle-keyboard-shortcuts-inhibit = { };
          allow-inhibiting = false;
        };
        "Mod+Shift+E" = {
          action.quit.skip-confirmation = false;
        };
        "Ctrl+Alt+Delete" = {
          action.quit.skip-confirmation = false;
        };
        "Mod+Shift+P" = {
          action.power-off-monitors = { };
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
        "Mod+O" = {
          action.toggle-overview = { };
        };
        "Mod+Q" = {
          action.close-window = { };
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
        "Mod+Home" = {
          action.focus-column-first = { };
        };
        "Mod+End" = {
          action.focus-column-last = { };
        };
        "Mod+Ctrl+Home" = {
          action.move-column-to-first = { };
        };
        "Mod+Ctrl+End" = {
          action.move-column-to-last = { };
        };
        "Mod+Ctrl+Alt+Up" = {
          action.focus-monitor-up = { };
        };
        "Mod+Ctrl+Alt+Down" = {
          action.focus-monitor-down = { };
        };
        "Mod+Ctrl+Alt+Left" = {
          action.focus-monitor-left = { };
        };
        "Mod+Ctrl+Alt+Right" = {
          action.focus-monitor-right = { };
        };
        "Mod+Shift+Ctrl+Alt+Up" = {
          action.move-column-to-monitor-up = { };
        };
        "Mod+Shift+Ctrl+Alt+Down" = {
          action.move-column-to-monitor-down = { };
        };
        "Mod+Shift+Ctrl+Alt+Left" = {
          action.move-column-to-monitor-left = { };
        };
        "Mod+Shift+Ctrl+Alt+Right" = {
          action.move-column-to-monitor-right = { };
        };
        "Mod+Page_Up" = {
          action.focus-workspace-up = { };
        };
        "Mod+Page_Down" = {
          action.focus-workspace-down = { };
        };
        "Mod+Ctrl+Page_Up" = {
          action.move-column-to-workspace-up = { };
        };
        "Mod+Ctrl+Page_Down" = {
          action.move-column-to-workspace-down = { };
        };
        "Mod+Shift+Page_Up" = {
          action.move-workspace-up = { };
        };
        "Mod+Shift+Page_Down" = {
          action.move-workspace-down = { };
        };
        "Mod+Tab" = {
          action.focus-workspace-previous = { };
        };
        "Mod+BracketLeft" = {
          action.consume-or-expel-window-left = { };
        };
        "Mod+BracketRight" = {
          action.consume-or-expel-window-right = { };
        };
        "Mod+Comma" = {
          action.consume-window-into-column = { };
        };
        "Mod+Period" = {
          action.expel-window-from-column = { };
        };
        "Mod+Minus" = {
          action.set-column-width = "-10%";
        };
        "Mod+Equal" = {
          action.set-column-width = "+10%";
        };
        "Mod+Shift+Minus" = {
          action.set-window-height = "-10%";
        };
        "Mod+Shift+Equal" = {
          action.set-window-height = "+10%";
        };
        "Mod+Alt+Up" = {
          action.set-window-height = "-40";
        };
        "Mod+Alt+Down" = {
          action.set-window-height = "+40";
        };
        "Mod+Alt+Left" = {
          action.set-column-width = "-40";
        };
        "Mod+Alt+Right" = {
          action.set-column-width = "+40";
        };
        "Mod+WheelScrollDown" = {
          action.focus-workspace-down = { };
          cooldown-ms = 150;
        };
        "Mod+WheelScrollUp" = {
          action.focus-workspace-up = { };
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollDown" = {
          action.move-column-to-workspace-down = { };
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollUp" = {
          action.move-column-to-workspace-up = { };
          cooldown-ms = 150;
        };
        "Print" = {
          action.screenshot = { };
        };
        "Ctrl+Print" = {
          action.screenshot-screen = { };
        };
        "Alt+Print" = {
          action.screenshot-window = { };
        };
        "XF86AudioRaiseVolume" = {
          action.spawn-sh = "${wpctl} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && ${notifyVolume}";
          allow-when-locked = true;
        };
        "XF86AudioLowerVolume" = {
          action.spawn-sh = "${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%- && ${notifyVolume}";
          allow-when-locked = true;
        };
        "XF86AudioMute" = {
          action.spawn-sh = "${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle && ${notifyVolumeMute}";
          allow-when-locked = true;
        };
        "XF86AudioMicMute" = {
          action.spawn-sh = "${wpctl} set-mute @DEFAULT_AUDIO_SOURCE@ toggle && ${notifyMicMute}";
          allow-when-locked = true;
        };
        "XF86AudioPlay" = {
          action.spawn = [
            playerctl
            "play-pause"
          ];
          allow-when-locked = true;
        };
        "XF86AudioPause" = {
          action.spawn = [
            playerctl
            "play-pause"
          ];
          allow-when-locked = true;
        };
        "XF86AudioNext" = {
          action.spawn = [
            playerctl
            "next"
          ];
          allow-when-locked = true;
        };
        "XF86AudioPrev" = {
          action.spawn = [
            playerctl
            "previous"
          ];
          allow-when-locked = true;
        };
      }
      // workspaceBinds;
    };
}
