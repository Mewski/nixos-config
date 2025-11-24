{ inputs, ... }:
{
  flake.homeModules.binary-ninja = {
    imports = [ inputs.nixvim.homeModules.binaryninja ];

    programs.binary-ninja.enable = true;
  };
}
