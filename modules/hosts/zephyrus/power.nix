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
            while true; do
              STATUS=$(cat /sys/class/power_supply/ACAD/online)
              CURRENT_RATE=$(${lib.getExe' pkgs.hyprland "hyprctl"} monitors -j | ${lib.getExe pkgs.jq} -r '.[] | select(.name == "eDP-1") | .refreshRate | floor')
              if [ "$STATUS" = "1" ]; then
                [ "$CURRENT_RATE" != "240" ] && ${lib.getExe' pkgs.hyprland "hyprctl"} keyword monitor 'eDP-1, 2560x1600@240, 0x0, 1.25, vrr, 1, bitdepth, 10'
              else
                [ "$CURRENT_RATE" != "60" ] && ${lib.getExe' pkgs.hyprland "hyprctl"} keyword monitor 'eDP-1, 2560x1600@60, 0x0, 1.25, vrr, 1, bitdepth, 10'
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
