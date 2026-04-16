{
  flake.homeModules.niri =
    { scheme, ... }:
    {
      programs.niri.settings.layout = {
        focus-ring = {
          enable = true;
          width = 2;
          active.color = "#${scheme.base0D}";
          inactive.color = "#${scheme.base03}";
        };
      };
    };
}
