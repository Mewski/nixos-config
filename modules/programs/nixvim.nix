{ inputs, ... }:
{
  flake.homeModules.nixvim = {
    imports = [ inputs.nixvim.homeModules.nixvim ];

    programs.nixvim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
