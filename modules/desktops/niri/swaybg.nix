{
  flake.homeModules.niri =
    {
      lib,
      pkgs,
      theme,
      ...
    }:
    {
      programs.niri.settings.spawn-at-startup = [
        {
          argv = [
            (lib.getExe pkgs.swaybg)
            "--image"
            (toString theme.wallpaper)
            "--mode"
            "fill"
          ];
        }
      ];

      home.packages = [ pkgs.swaybg ];
    };
}
