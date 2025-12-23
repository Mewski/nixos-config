{
  flake.homeModules.hyprlock =
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
          fade_on_empty = false;
          placeholder_text = ''<span font_style="normal">Input Password</span>'';
          fail_text = ''<span font_style="normal">Authentication Failed</span>'';
        };
        label = [
          {
            text = ''cmd[update:1000] date +"%H:%M:%S"'';
            color = "rgb(${scheme.base05})";
            font_size = 96;
            position = "0, -100";
            halign = "center";
            valign = "top";
          }
          {
            text = ''cmd[update:1000] date +"%A, %B %d"'';
            color = "rgb(${scheme.base05})";
            font_size = 24;
            position = "0, -250";
            halign = "center";
            valign = "top";
          }
        ];
      };
    };
}
