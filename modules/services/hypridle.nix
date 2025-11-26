{
  flake.homeModules.hypridle =
    { lib, pkgs, ... }:
    {
      services.hypridle = {
        enable = true;

        settings = {
          general = {
            before_sleep_cmd = "${lib.getExe pkgs.hyprlock}";
            after_sleep_cmd = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms on";
            ignore_dbus_inhibit = false;
            lock_cmd = "${lib.getExe pkgs.hyprlock}";
          };

          listener = [
            {
              timeout = 190;
              on-timeout = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms off";
              on-resume = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms on";
            }
            {
              timeout = 195;
              on-timeout = "systemctl suspend";
            }
          ];
        };
      };
    };
}
