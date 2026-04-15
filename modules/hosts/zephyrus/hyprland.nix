{
  flake.homeModules.zephyrus =
    {
      lib,
      pkgs,
      theme,
      ...
    }:
    let
      s = theme.scale;
      scale = lib.strings.floatToString s;
      pos = x: y: "${toString (builtins.floor (x / s))}x${toString (builtins.floor (y / s))}";
      brightnessctl = lib.getExe pkgs.brightnessctl;
      hyprctl = lib.getExe' pkgs.hyprland "hyprctl";
      jq = lib.getExe pkgs.jq;
      notify = lib.getExe pkgs.libnotify;
      socat = lib.getExe pkgs.socat;
      udevadm = lib.getExe' pkgs.systemd "udevadm";

      kbdBacklight = "asus::kbd_backlight";
      intelBacklight = "intel_backlight";
      nvidiaBacklight = "nvidia_0";
      internalDisplayConfig = "eDP-1, 2560x1600@240, 0x0, ${scale}, vrr, 1, bitdepth, 10";
      monitorHighRefresh = internalDisplayConfig;
      monitorLowRefresh = "eDP-1, 2560x1600@60, 0x0, ${scale}, vrr, 1, bitdepth, 10";

      stateFile = "/tmp/power-state-last";

      getKbdBrightness = "${brightnessctl} -d ${kbdBacklight} -m | cut -d, -f4 | tr -d '%'";

      notifyKbdBrightness = pkgs.writeShellScript "notify-kbd-brightness" ''
        ${notify} -a osd -t 1000 \
          -h string:x-dunst-stack-tag:kbd \
          -h int:value:$(${getKbdBrightness}) \
          'Keyboard Brightness'
      '';

      setDisplayBrightness =
        direction:
        pkgs.writeShellScript "set-display-brightness-${direction}" ''
          if [ -d "/sys/class/backlight/${nvidiaBacklight}" ]; then
            val=$(${brightnessctl} -d ${nvidiaBacklight} -m set 5%${direction} | cut -d, -f4 | tr -d '%')
          fi

          if [ -d "/sys/class/backlight/${intelBacklight}" ]; then
            val=$(${brightnessctl} -d ${intelBacklight} -m set 5%${direction} | cut -d, -f4 | tr -d '%')
          fi

          ${notify} -a osd -t 1000 \
            -h string:x-dunst-stack-tag:brightness \
            -h int:value:''${val:-0} \
            'Display Brightness'
        '';

      dimDisplay = pkgs.writeShellScript "dim-display" ''
        ${brightnessctl} -d ${intelBacklight} -s set 1%
        ${brightnessctl} -d ${nvidiaBacklight} -s set 1%
      '';

      restoreDisplay = pkgs.writeShellScript "restore-display" ''
        ${brightnessctl} -d ${intelBacklight} -r
        ${brightnessctl} -d ${nvidiaBacklight} -r
      '';

      assignWorkspaces = pkgs.writeShellScript "assign-workspaces" ''
        ${hyprctl} reload >/dev/null 2>&1
        sleep 1

        monitors=$(${hyprctl} monitors -j | ${jq} -r '.[].name')
        count=$(echo "$monitors" | wc -l)
        has_dp=$(echo "$monitors" | grep -c "^DP-1$")
        has_hdmi=$(echo "$monitors" | grep -c "^HDMI-A-1$")

        assign() {
          ${hyprctl} --batch \
            "keyword workspace $1, monitor:$2, default:$3 ; \
             dispatch moveworkspacetomonitor $1 $2" >/dev/null 2>&1
        }

        if [ "$count" -ge 3 ] && [ "$has_dp" -eq 1 ] && [ "$has_hdmi" -eq 1 ]; then
          for i in 1 2 3 4; do assign "$i" eDP-1 "$([ "$i" -eq 1 ] && echo true || echo false)"; done
          for i in 5 6 7;   do assign "$i" DP-1 "$([ "$i" -eq 5 ] && echo true || echo false)"; done
          for i in 8 9 10;  do assign "$i" HDMI-A-1 "$([ "$i" -eq 8 ] && echo true || echo false)"; done
          ${hyprctl} dispatch workspace 1 >/dev/null 2>&1
        elif [ "$count" -eq 2 ]; then
          for i in 1 2 3 4 5; do assign "$i" eDP-1 "$([ "$i" -eq 1 ] && echo true || echo false)"; done
          if [ "$has_dp" -eq 1 ]; then secondary=DP-1; else secondary=HDMI-A-1; fi
          for i in 6 7 8 9 10; do assign "$i" "$secondary" "$([ "$i" -eq 6 ] && echo true || echo false)"; done
          ${hyprctl} dispatch workspace 1 >/dev/null 2>&1
        else
          for i in 1 2 3 4 5 6 7 8 9 10; do assign "$i" eDP-1 "$([ "$i" -eq 1 ] && echo true || echo false)"; done
        fi

        stray_workspaces=$(${hyprctl} workspaces -j | ${jq} -r '.[] | select(.id > 10) | .id')
        for ws in $stray_workspaces; do
          ws_mon=$(${hyprctl} workspaces -j | ${jq} -r ".[] | select(.id == $ws) | .monitor")
          if [ "$ws_mon" = "eDP-1" ]; then target_ws=1;
          elif [ "$ws_mon" = "DP-1" ]; then
            if [ "$count" -ge 3 ]; then target_ws=5; else target_ws=6; fi
          elif [ "$ws_mon" = "HDMI-A-1" ]; then target_ws=8;
          else target_ws=1; fi

          for addr in $(${hyprctl} clients -j | ${jq} -r ".[] | select(.workspace.id == $ws) | .address"); do
            ${hyprctl} dispatch movetoworkspace "$target_ws,address:$addr" >/dev/null 2>&1
          done

          ${hyprctl} --batch \
            "dispatch focusmonitor $ws_mon ; \
             dispatch workspace $target_ws" >/dev/null 2>&1
        done
      '';

      monitorEventListener = pkgs.writeShellScript "monitor-event-listener" ''
        trap "" HUP
        ${socat} -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | \
          while IFS= read -r line; do
            case "$line" in
              monitoradded*|monitorremoved*)
                sleep 1
                ${assignWorkspaces}
                ;;
            esac
          done
      '';

      applyPowerState = pkgs.writeShellScript "apply-power-state" ''
        STATUS=$(cat /sys/class/power_supply/ACAD/online)
        PREV=$(cat ${stateFile} 2>/dev/null || echo "")

        MONITOR_JSON=$(${hyprctl} monitors -j)
        MONITOR_COUNT=$(echo "$MONITOR_JSON" | ${jq} '[.[] | select(.name == "eDP-1")] | length')

        if [ "$MONITOR_COUNT" -gt 0 ]; then
          CURRENT_RATE=$(echo "$MONITOR_JSON" | ${jq} -r '.[] | select(.name == "eDP-1") | .refreshRate | round')

          if [ "$STATUS" = "1" ]; then
            [ "$CURRENT_RATE" -ne 240 ] && ${hyprctl} keyword monitor '${monitorHighRefresh}'
          else
            [ "$CURRENT_RATE" -ne 60 ] && ${hyprctl} keyword monitor '${monitorLowRefresh}'
          fi
        fi

        if [ "$STATUS" = "$PREV" ]; then
          exit 0
        fi

        echo "$STATUS" > ${stateFile}

        if [ "$STATUS" = "1" ]; then
          ${notify} -a osd-text -t 5000 -h string:x-dunst-stack-tag:power "Power Connected"
        else
          ${notify} -a osd-text -t 5000 -h string:x-dunst-stack-tag:power "Power Disconnected"
        fi
      '';

      batteryRefreshRate = pkgs.writeShellScript "battery-refresh-rate" ''
        ${applyPowerState}

        ${udevadm} monitor -u -s power_supply | while read -r line; do
          case "$line" in
            *change*|*POWER_SUPPLY*)
              ${applyPowerState}
              ;;
          esac
        done
      '';
    in
    {
      wayland.windowManager.hyprland.settings = {
        monitor = [
          internalDisplayConfig
          "DP-1, highrr, ${pos 2560 0}, ${scale}"
          "desc:LG Electronics LG ULTRAGEAR+ 0x01010101, 3440x1440@240, ${pos (-440) (-1440)}, ${scale}"
          "HDMI-A-1, highrr, auto-up, ${scale}"
          ", highrr, auto, ${scale}"
        ];

        exec-once = [
          "${assignWorkspaces}"
          "${monitorEventListener}"
        ];

        input.touchpad = {
          clickfinger_behavior = true;
          disable_while_typing = true;
          natural_scroll = true;
          scroll_factor = 0.25;
        };

        device = {
          name = "asup1207:00-093a:3012-touchpad";
          sensitivity = 0.25;
        };

        bindel = [
          ",XF86KbdBrightnessDown, exec, ${brightnessctl} -d ${kbdBacklight} set 1- && ${notifyKbdBrightness}"
          ",XF86KbdBrightnessUp, exec, ${brightnessctl} -d ${kbdBacklight} set 1+ && ${notifyKbdBrightness}"
          ",XF86MonBrightnessDown, exec, ${setDisplayBrightness "-"}"
          ",XF86MonBrightnessUp, exec, ${setDisplayBrightness "+"}"
        ];
      };

      services.hypridle.settings.listener = [
        {
          timeout = 180;
          on-timeout = "${dimDisplay}";
          on-resume = "${restoreDisplay}";
        }
      ];

      systemd.user.services.battery-refresh-rate = {
        Unit = {
          Description = "Adjust display refresh rate based on battery status";
          After = [ "graphical-session.target" ];
          PartOf = [ "graphical-session.target" ];
        };
        Service = {
          Type = "simple";
          ExecStart = batteryRefreshRate;
          Restart = "on-failure";
          RestartSec = 5;
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };

      home.packages = [ pkgs.wootility ];
    };
}
