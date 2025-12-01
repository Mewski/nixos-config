{
  flake.homeModules.zephyrus =
    { pkgs, lib, ... }:
    {
      systemd.user.services.battery-refresh-rate = {
        Unit = {
          Description = "Adjust display refresh rate based on battery status";
          After = [ "graphical-session.target" ];
          PartOf = [ "graphical-session.target" ];
        };
        Service = {
          Type = "simple";
          ExecStart = pkgs.writeShellScript "battery-refresh-rate" ''
            LAST_STATUS=""
            while true; do
              STATUS=$(cat /sys/class/power_supply/ACAD/online)

              if [ "$STATUS" != "$LAST_STATUS" ]; then
                if [ "$STATUS" = "1" ]; then
                  ${lib.getExe' pkgs.hyprland "hyprctl"} keyword monitor 'eDP-1, 2560x1600@240, 0x0, 1.25, vrr, 1, bitdepth, 10'
                else
                  ${lib.getExe' pkgs.hyprland "hyprctl"} keyword monitor 'eDP-1, 2560x1600@60, 0x0, 1.25, vrr, 1, bitdepth, 10'
                fi
                LAST_STATUS="$STATUS"
              fi
              sleep 5
            done
          '';
          Restart = "on-failure";
          RestartSec = 5;
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
    };
}
