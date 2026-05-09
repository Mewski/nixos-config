{
  flake.homeModules.niri =
    {
      scheme,
      theme,
      ...
    }:
    {
      programs.niri.settings = {
        layout = {
          background-color = "#${scheme.base00}";
          gaps = theme.gap;
          border = {
            enable = true;
            width = 2;
          };
          focus-ring.enable = false;
          shadow.enable = false;
          tab-indicator = {
            hide-when-single-tab = true;
            place-within-column = true;
            gap = 4;
            width = 4;
            position = "right";
            gaps-between-tabs = 2;
            corner-radius = theme.rounding;
          };
        };

        overview = {
          backdrop-color = "#${scheme.base00}";
          workspace-shadow.enable = false;
        };

        animations.enable = true;
      };
    };
}
