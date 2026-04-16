{
  flake.homeModules.zephyrus =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.wootility ];
    };
}
