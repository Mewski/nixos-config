{
  flake.homeModules.ida-pro =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.ida-pro-wayland ];
    };
}
