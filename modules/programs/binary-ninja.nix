{ inputs, ... }:
{
  flake.nixosModules.binary-ninja =
    { pkgs, ... }:
    {
      imports = [ inputs.binary-ninja.nixosModules.binaryninja ];

      programs.binary-ninja = {
        enable = true;
        package = pkgs.binary-ninja-personal-wayland;
      };
    };
}
