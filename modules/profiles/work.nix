{
  flake.nixosModules.work = { };

  flake.homeModules.work =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.zoom-us
      ];
    };
}
