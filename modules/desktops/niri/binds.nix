{
  flake.homeModules.niri =
    { lib, pkgs, ... }:
    let
      kitty = lib.getExe pkgs.kitty;
      rofi = lib.getExe pkgs.rofi;
      swaylock = lib.getExe pkgs.swaylock;
      bitwarden = lib.getExe pkgs.bitwarden-desktop;
      nautilus = lib.getExe pkgs.nautilus;
      btop = lib.getExe pkgs.btop;
      zed = lib.getExe pkgs.zed-editor;
      hyprpicker = lib.getExe pkgs.hyprpicker;
      tesseract = lib.getExe pkgs.tesseract;
      hyprshot = lib.getExe pkgs.hyprshot;
      cliphist = lib.getExe pkgs.cliphist;
      playerctl = lib.getExe pkgs.playerctl;
      wlcopy = lib.getExe' pkgs.wl-clipboard "wl-copy";
      wpctl = lib.getExe' pkgs.wireplumber "wpctl";
      notify = lib.getExe pkgs.libnotify;

      cliphistSelect = pkgs.writeShellScript "cliphist-select" ''
        selected=$(${cliphist} list | ${rofi} -dmenu -display-columns 2 -no-show-icons)
        if [ -n "$selected" ]; then
          echo "$selected" | ${cliphist} decode | ${wlcopy}
          ${notify} -a osd-text -t 1000 'Copied to clipboard'
        fi
      '';

      ocr = pkgs.writeShellScript "ocr" ''
        ${hyprshot} -m region -z --raw | ${tesseract} - - | ${wlcopy}
        ${notify} -a osd-text -t 1000 'Text copied to clipboard'
      '';

      notifyVolume = pkgs.writeShellScript "notify-volume" ''
        ${notify} -a osd -t 1000 \
          -h string:x-dunst-stack-tag:volume \
          -h int:value:$(${wpctl} get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}') \
          'System Volume'
      '';

      workspaceBinds = builtins.listToAttrs (
        builtins.concatLists (
          builtins.genList (
            i:
            let
              key = if i == 0 then "0" else toString i;
              ws = if i == 0 then 10 else i;
            in
            [
              {
                name = "Mod+${key}";
                value.action.focus-workspace = ws;
              }
              {
                name = "Mod+Shift+${key}";
                value.action.move-window-to-workspace = ws;
              }
            ]
          ) 10
        )
      );
    in
    {
      programs.niri.settings.binds = {
        "Mod+R".action.spawn = [
          rofi
          "-show"
          "drun"
        ];
        "Mod+Q".action.spawn = kitty;
        "Mod+L".action.spawn = [
          swaylock
          "-f"
        ];
        "Mod+U".action.spawn = bitwarden;
        "Mod+E".action.spawn = nautilus;
        "Mod+I".action.spawn = [
          kitty
          btop
        ];
        "Mod+K".action.spawn = "${cliphistSelect}";
        "Mod+Z".action.spawn = zed;
        "Mod+D".action.spawn = "discord";
        "Mod+B".action.spawn = "zen-beta";

        "Mod+S".action.spawn = [
          hyprpicker
          "-a"
          "-r"
        ];
        "Mod+Shift+S".action.screenshot = { };
        "Mod+Alt+S".action.screenshot-window = { };
        "Mod+Ctrl+S".action.screenshot-screen = { };
        "Mod+O".action.spawn = "${ocr}";

        "Mod+A".action.toggle-overview = { };

        "Mod+C".action.close-window = { };
        "Mod+F".action.fullscreen-window = { };
        "Mod+Shift+F".action.maximize-column = { };
        "Mod+V".action.toggle-window-floating = { };
        "Mod+Shift+M".action.quit = { };

        "Mod+Left".action.focus-column-left = { };
        "Mod+Right".action.focus-column-right = { };
        "Mod+Up".action.focus-window-up = { };
        "Mod+Down".action.focus-window-down = { };

        "Mod+Shift+Left".action.move-column-left = { };
        "Mod+Shift+Right".action.move-column-right = { };
        "Mod+Shift+Up".action.move-window-up = { };
        "Mod+Shift+Down".action.move-window-down = { };

        "Mod+Comma".action.consume-window-into-column = { };
        "Mod+Period".action.expel-window-from-column = { };

        "Mod+WheelScrollDown".action.focus-workspace-down = { };
        "Mod+WheelScrollUp".action.focus-workspace-up = { };
        "Mod+Page_Down".action.focus-workspace-down = { };
        "Mod+Page_Up".action.focus-workspace-up = { };

        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action.spawn = [
            "sh"
            "-c"
            "${wpctl} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && ${notifyVolume}"
          ];
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action.spawn = [
            "sh"
            "-c"
            "${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%- && ${notifyVolume}"
          ];
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          action.spawn = [
            wpctl
            "set-mute"
            "@DEFAULT_AUDIO_SINK@"
            "toggle"
          ];
        };
        "XF86AudioMicMute" = {
          allow-when-locked = true;
          action.spawn = [
            wpctl
            "set-mute"
            "@DEFAULT_AUDIO_SOURCE@"
            "toggle"
          ];
        };

        "XF86AudioPlay" = {
          allow-when-locked = true;
          action.spawn = [
            playerctl
            "play-pause"
          ];
        };
        "XF86AudioNext" = {
          allow-when-locked = true;
          action.spawn = [
            playerctl
            "next"
          ];
        };
        "XF86AudioPrev" = {
          allow-when-locked = true;
          action.spawn = [
            playerctl
            "previous"
          ];
        };
      }
      // workspaceBinds;
    };
}
