{ inputs, ... }:
{
  flake.homeModules.meridian =
    { pkgs, ... }:
    {
      imports = [ inputs.meridian.homeManagerModules.default ];

      services.meridian = {
        enable = true;
        package = inputs.meridian.packages.${pkgs.system}.default;
      };
    };
}
