{
  flake.homeModules.crosshair =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.wootility ];
    };
}
