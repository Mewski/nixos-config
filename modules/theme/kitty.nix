{
  flake.homeModules.kitty =
    {
      scheme,
      fonts,
      opacity,
      ...
    }:
    {
      programs.kitty = {
        font = {
          name = fonts.monospace.name;
          size = fonts.sizes.terminal;
        };

        settings = {
          background_opacity = opacity.terminal;

          background = scheme.withHashtag.base00;
          foreground = scheme.withHashtag.base05;
          selection_background = scheme.withHashtag.base05;
          selection_foreground = scheme.withHashtag.base00;

          cursor = scheme.withHashtag.base05;
          cursor_text_color = scheme.withHashtag.base00;

          url_color = scheme.withHashtag.base04;

          active_border_color = scheme.withHashtag.base03;
          inactive_border_color = scheme.withHashtag.base01;

          wayland_titlebar_color = scheme.withHashtag.base00;
          macos_titlebar_color = scheme.withHashtag.base00;

          active_tab_background = scheme.withHashtag.base00;
          active_tab_foreground = scheme.withHashtag.base05;
          inactive_tab_background = scheme.withHashtag.base01;
          inactive_tab_foreground = scheme.withHashtag.base04;
          tab_bar_background = scheme.withHashtag.base01;

          color0 = scheme.withHashtag.base00;
          color1 = scheme.withHashtag.base08;
          color2 = scheme.withHashtag.base0B;
          color3 = scheme.withHashtag.base0A;
          color4 = scheme.withHashtag.base0D;
          color5 = scheme.withHashtag.base0E;
          color6 = scheme.withHashtag.base0C;
          color7 = scheme.withHashtag.base05;

          color8 = scheme.withHashtag.base02;
          color9 = scheme.withHashtag.base12;
          color10 = scheme.withHashtag.base14;
          color11 = scheme.withHashtag.base13;
          color12 = scheme.withHashtag.base16;
          color13 = scheme.withHashtag.base17;
          color14 = scheme.withHashtag.base15;
          color15 = scheme.withHashtag.base07;

          color16 = scheme.withHashtag.base09;
          color17 = scheme.withHashtag.base0F;
          color18 = scheme.withHashtag.base01;
          color19 = scheme.withHashtag.base02;
          color20 = scheme.withHashtag.base04;
          color21 = scheme.withHashtag.base06;
        };
      };
    };
}
