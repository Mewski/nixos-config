{
  flake.homeModules.zephyrus =
    { lib, pkgs, ... }:
    let
      hyprctl = lib.getExe' pkgs.hyprland "hyprctl";
      jq = lib.getExe pkgs.jq;
      notify = lib.getExe pkgs.libnotify;
      udevadm = lib.getExe' pkgs.systemd "udevadm";

      monitorHighRefresh = "eDP-1, 2560x1600@240, 0x0, 1.25, vrr, 1, bitdepth, 10";
      monitorLowRefresh = "eDP-1, 2560x1600@60, 0x0, 1.25, vrr, 1, bitdepth, 10";

      stateFile = "/tmp/power-state-last";

      applyPowerState = pkgs.writeShellScript "apply-power-state" ''
        STATUS=$(cat /sys/class/power_supply/ACAD/online)
        PREV=$(cat ${stateFile} 2>/dev/null || echo "")

        if [ "$STATUS" = "$PREV" ]; then
          exit 0
        fi

        echo "$STATUS" > ${stateFile}

        MONITOR_JSON=$(${hyprctl} monitors -j)
        MONITOR_COUNT=$(echo "$MONITOR_JSON" | ${jq} '[.[] | select(.name == "eDP-1")] | length')

        if [ "$STATUS" = "1" ]; then
          ${notify} -a osd-text -t 5000 -h string:x-dunst-stack-tag:power "Power Connected"
        else
          ${notify} -a osd-text -t 5000 -h string:x-dunst-stack-tag:power "Power Disconnected"
        fi

        if [ "$MONITOR_COUNT" -gt 0 ]; then
          CURRENT_RATE=$(echo "$MONITOR_JSON" | ${jq} -r '.[] | select(.name == "eDP-1") | .refreshRate | round')

          if [ "$STATUS" = "1" ]; then
            [ "$CURRENT_RATE" -ne 240 ] && ${hyprctl} keyword monitor '${monitorHighRefresh}'
          else
            [ "$CURRENT_RATE" -ne 60 ] && ${hyprctl} keyword monitor '${monitorLowRefresh}'
          fi
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
    };
}
