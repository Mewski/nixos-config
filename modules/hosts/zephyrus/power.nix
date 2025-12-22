{
  flake.homeModules.zephyrus =
    { lib, pkgs, ... }:
    let
      hyprctl = lib.getExe' pkgs.hyprland "hyprctl";
      jq = lib.getExe pkgs.jq;

      monitorHighRefresh = "eDP-1, 2560x1600@240, 0x0, 1.25, vrr, 1, bitdepth, 10";
      monitorLowRefresh = "eDP-1, 2560x1600@60, 0x0, 1.25, vrr, 1, bitdepth, 10";

      batteryRefreshRate = pkgs.writeShellScript "battery-refresh-rate" ''
        while true; do
          STATUS=$(cat /sys/class/power_supply/ACAD/online)
          MONITOR_COUNT=$(${hyprctl} monitors -j | ${jq} '[.[] | select(.name == "eDP-1")] | length')

          if [ "$MONITOR_COUNT" -gt 0 ]; then
            CURRENT_RATE=$(${hyprctl} monitors -j | ${jq} -r '.[] | select(.name == "eDP-1") | .refreshRate | floor')

            if [ "$STATUS" = "1" ]; then
              [ "$CURRENT_RATE" != "240" ] && ${hyprctl} keyword monitor '${monitorHighRefresh}'
            else
              [ "$CURRENT_RATE" != "60" ] && ${hyprctl} keyword monitor '${monitorLowRefresh}'
            fi
          fi

          sleep 5
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

        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
    };
}
