{ inputs, ... }:
{
  flake.homeModules.nixvim = {
    imports = [ inputs.nixvim.homeModules.nixvim ];

    programs.nixvim = {
      enable = true;

      defaultEditor = true;

      opts = {
        number = true;
        relativenumber = true;

        shiftwidth = 2;
      };
    };
  };
}
