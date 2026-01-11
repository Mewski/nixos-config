{
  flake.homeModules.osu =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.osu-lazer-bin ];
    };
}
