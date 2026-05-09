{
  flake.homeModules.niri =
    { scheme, ... }:
    {
      programs.niri.settings.layout = {
        border = {
          active.color = "#${scheme.base0D}";
          inactive.color = "#${scheme.base03}";
        };
        tab-indicator = {
          active.color = "#${scheme.base0D}";
          inactive.color = "#${scheme.base03}";
          urgent.color = "#${scheme.base08}";
        };
      };
    };
}
