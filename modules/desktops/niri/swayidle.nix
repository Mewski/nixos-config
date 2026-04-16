{
  flake.homeModules.niri =
    { lib, pkgs, ... }:
    let
      niri = lib.getExe pkgs.niri;
      swaylock = lib.getExe pkgs.swaylock;
    in
    {
      services.swayidle = {
        enable = true;

        events = {
          before-sleep = "loginctl lock-session";
          lock = "${swaylock} -f";
        };

        timeouts = [
          {
            timeout = 195;
            command = "${niri} msg action power-off-monitors";
            resumeCommand = "${niri} msg action power-on-monitors";
          }
          {
            timeout = 300;
            command = "systemctl suspend";
          }
        ];
      };
    };
}
