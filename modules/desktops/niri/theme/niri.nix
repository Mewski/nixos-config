{
  flake.homeModules.niri =
    { scheme, ... }:
    {
      programs.niri.settings.layout = {
        focus-ring = {
          active.color = "#${scheme.base0D}";
          inactive.color = "#${scheme.base03}";
        };
        border = {
          active.color = "#${scheme.base0D}";
          inactive.color = "#${scheme.base03}";
        };
      };
    };
}
