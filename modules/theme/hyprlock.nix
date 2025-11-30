{
  flake.homeModules.theme =
    { scheme, ... }:
    {
      programs.hyprlock.settings = {
        background = {
          color = "rgb(${scheme.base00})";
        };
        input-field = {
          outer_color = "rgb(${scheme.base03})";
          inner_color = "rgb(${scheme.base00})";
          font_color = "rgb(${scheme.base05})";
          fail_color = "rgb(${scheme.base08})";
          check_color = "rgb(${scheme.base0A})";
        };
      };
    };
}
