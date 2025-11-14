{
  flake.homeModules.kitty =
    { config, ... }:
    {
      programs.kitty = {
        enable = true;

        font = {
          name = config.fonts.monospace.name;
          size = config.fonts.monospace.size;
        };

        shellIntegration.enableFishIntegration = true;

        enableGitIntegration = true;

        settings = {
          cursor_trail = 1;
          confirm_os_window_close = 0;

          background = config.scheme.withHashtag.base00;
          foreground = config.scheme.withHashtag.base05;
          selection_background = config.scheme.withHashtag.base05;
          selection_foreground = config.scheme.withHashtag.base00;

          cursor = config.scheme.withHashtag.base05;
          cursor_text_color = config.scheme.withHashtag.base00;

          url_color = config.scheme.withHashtag.base04;

          active_border_color = config.scheme.withHashtag.base03;
          inactive_border_color = config.scheme.withHashtag.base01;

          wayland_titlebar_color = config.scheme.withHashtag.base00;
          macos_titlebar_color = config.scheme.withHashtag.base00;

          active_tab_background = config.scheme.withHashtag.base00;
          active_tab_foreground = config.scheme.withHashtag.base05;
          inactive_tab_background = config.scheme.withHashtag.base01;
          inactive_tab_foreground = config.scheme.withHashtag.base04;
          tab_bar_background = config.scheme.withHashtag.base01;

          color0 = config.scheme.withHashtag.base00;
          color1 = config.scheme.withHashtag.base08;
          color2 = config.scheme.withHashtag.base0B;
          color3 = config.scheme.withHashtag.base0A;
          color4 = config.scheme.withHashtag.base0D;
          color5 = config.scheme.withHashtag.base0E;
          color6 = config.scheme.withHashtag.base0C;
          color7 = config.scheme.withHashtag.base05;

          color8 = config.scheme.withHashtag.base02;
          color9 = config.scheme.withHashtag.base12;
          color10 = config.scheme.withHashtag.base14;
          color11 = config.scheme.withHashtag.base13;
          color12 = config.scheme.withHashtag.base16;
          color13 = config.scheme.withHashtag.base17;
          color14 = config.scheme.withHashtag.base15;
          color15 = config.scheme.withHashtag.base07;

          color16 = config.scheme.withHashtag.base09;
          color17 = config.scheme.withHashtag.base0F;
          color18 = config.scheme.withHashtag.base01;
          color19 = config.scheme.withHashtag.base02;
          color20 = config.scheme.withHashtag.base04;
          color21 = config.scheme.withHashtag.base06;
        };
      };
    };
}
