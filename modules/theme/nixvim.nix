{
  flake.homeModules.theme =
    { scheme, ... }:
    {
      programs.nixvim.colorschemes.base16 = {
        enable = true;
        colorscheme = {
          base00 = "#${scheme.base00}";
          base01 = "#${scheme.base01}";
          base02 = "#${scheme.base02}";
          base03 = "#${scheme.base03}";
          base04 = "#${scheme.base04}";
          base05 = "#${scheme.base05}";
          base06 = "#${scheme.base06}";
          base07 = "#${scheme.base07}";
          base08 = "#${scheme.base08}";
          base09 = "#${scheme.base09}";
          base0A = "#${scheme.base0A}";
          base0B = "#${scheme.base0B}";
          base0C = "#${scheme.base0C}";
          base0D = "#${scheme.base0D}";
          base0E = "#${scheme.base0E}";
          base0F = "#${scheme.base0F}";
        };
      };
    };
}
