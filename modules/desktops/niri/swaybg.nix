{
  flake.homeModules.niri =
    {
      lib,
      pkgs,
      theme,
      ...
    }:
    {
      systemd.user.services.swaybg = {
        Unit = {
          Description = "Wallpaper daemon";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };
        Install.WantedBy = [ "graphical-session.target" ];
        Service = {
          ExecStart = "${lib.getExe pkgs.swaybg} --image ${toString theme.wallpaper} --mode fill";
          Restart = "on-failure";
          RestartSec = 3;
        };
      };

      home.packages = [ pkgs.swaybg ];
    };
}
