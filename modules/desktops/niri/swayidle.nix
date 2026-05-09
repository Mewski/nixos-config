{
  flake.homeModules.niri =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      niri = lib.getExe config.programs.niri.package;
      swaylock = lib.getExe pkgs.swaylock;
      swayidle = lib.getExe pkgs.swayidle;
    in
    {
      systemd.user.services.swayidle = {
        Unit = {
          Description = "Idle manager";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };
        Install.WantedBy = [ "graphical-session.target" ];
        Service = {
          ExecStart = ''
            ${swayidle} -w \
              before-sleep 'loginctl lock-session' \
              lock 'pidof swaylock || ${swaylock} --daemonize' \
              timeout 195 '${niri} msg action power-off-monitors' resume '${niri} msg action power-on-monitors' \
              timeout 300 'systemctl suspend'
          '';
          Restart = "on-failure";
          RestartSec = 3;
        };
      };

      home.packages = [ pkgs.swayidle ];
    };
}
