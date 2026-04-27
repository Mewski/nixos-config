{
  flake.homeModules.hyprland =
    {
      theme,
      scheme,
      ...
    }:
    {
      programs.hyprlock.settings = {
        background = [
          {
            monitor = "";
            path = toString theme.wallpaper;
            blur_passes = 3;
            blur_size = 8;
            brightness = 0.7;
            contrast = 0.9;
            noise = 0.0117;
            vibrancy = 0.1696;
            vibrancy_darkness = 0.5;
          }
        ];
        shape = [
          {
            monitor = "";
            size = "100%, 100%";
            position = "0, 0";
            halign = "center";
            valign = "center";
            color = "rgba(${scheme.base00-rgb-r}, ${scheme.base00-rgb-g}, ${scheme.base00-rgb-b}, 0.4)";
            rounding = 0;
            border_size = 0;
            z_index = -1;
          }
        ];
        input-field = [
          {
            size = "400, 60";
            rounding = theme.rounding;
            outline_thickness = 2;
            outer_color = "rgb(${scheme.base03})";
            inner_color = "rgba(${scheme.base00-rgb-r}, ${scheme.base00-rgb-g}, ${scheme.base00-rgb-b}, ${toString theme.opacity.desktop})";
            font_color = "rgb(${scheme.base05})";
            fail_color = "rgb(${scheme.base08})";
            check_color = "rgb(${scheme.base0A})";
            fade_on_empty = false;
            placeholder_text = ''<span font_style="normal">Input Password</span>'';
            fail_text = ''<span font_style="normal">Authentication Failed</span>'';
          }
        ];
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
