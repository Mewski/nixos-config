{
  flake.nixosModules.gtk = {
    programs.dconf.enable = true;
  };

  flake.homeModules.gtk =
    {
      pkgs,
      theme,
      scheme,
      ...
    }:
    {
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = if theme.polarity == "dark" then "prefer-dark" else "default";
        };
      };

      gtk = {
        enable = true;

        theme = {
          package = pkgs.adw-gtk3;
          name = if theme.polarity == "dark" then "adw-gtk3-dark" else "adw-gtk3";
        };

        iconTheme = {
          package = pkgs.adwaita-icon-theme;
          name = "Adwaita";
        };

        font = {
          name = theme.fonts.sansSerif.name;
          size = theme.fonts.sizes.desktop;
        };

        gtk3.extraCss = ''
          @define-color accent_color ${scheme.withHashtag.base0D};
          @define-color accent_bg_color ${scheme.withHashtag.base0D};
          @define-color accent_fg_color ${scheme.withHashtag.base00};
          @define-color destructive_color ${scheme.withHashtag.base08};
          @define-color destructive_bg_color ${scheme.withHashtag.base08};
          @define-color destructive_fg_color ${scheme.withHashtag.base00};
          @define-color success_color ${scheme.withHashtag.base0B};
          @define-color success_bg_color ${scheme.withHashtag.base0B};
          @define-color success_fg_color ${scheme.withHashtag.base00};
          @define-color warning_color ${scheme.withHashtag.base0A};
          @define-color warning_bg_color ${scheme.withHashtag.base0A};
          @define-color warning_fg_color ${scheme.withHashtag.base00};
          @define-color error_color ${scheme.withHashtag.base08};
          @define-color error_bg_color ${scheme.withHashtag.base08};
          @define-color error_fg_color ${scheme.withHashtag.base00};
          @define-color window_bg_color ${scheme.withHashtag.base00};
          @define-color window_fg_color ${scheme.withHashtag.base05};
          @define-color view_bg_color ${scheme.withHashtag.base00};
          @define-color view_fg_color ${scheme.withHashtag.base05};
          @define-color headerbar_bg_color ${scheme.withHashtag.base01};
          @define-color headerbar_fg_color ${scheme.withHashtag.base05};
          @define-color headerbar_border_color ${scheme.withHashtag.base00};
          @define-color headerbar_backdrop_color ${scheme.withHashtag.base01};
          @define-color headerbar_shade_color rgba(0, 0, 0, 0.36);
          @define-color card_bg_color ${scheme.withHashtag.base01};
          @define-color card_fg_color ${scheme.withHashtag.base05};
          @define-color card_shade_color rgba(0, 0, 0, 0.36);
          @define-color dialog_bg_color ${scheme.withHashtag.base01};
          @define-color dialog_fg_color ${scheme.withHashtag.base05};
          @define-color popover_bg_color ${scheme.withHashtag.base01};
          @define-color popover_fg_color ${scheme.withHashtag.base05};
          @define-color shade_color rgba(0, 0, 0, 0.36);
          @define-color scrollbar_outline_color ${scheme.withHashtag.base00};
          @define-color sidebar_bg_color ${scheme.withHashtag.base00};
          @define-color sidebar_fg_color ${scheme.withHashtag.base05};
          @define-color sidebar_backdrop_color ${scheme.withHashtag.base01};
          @define-color sidebar_shade_color rgba(0, 0, 0, 0.36);
          @define-color secondary_sidebar_bg_color ${scheme.withHashtag.base00};
          @define-color secondary_sidebar_fg_color ${scheme.withHashtag.base05};
          @define-color secondary_sidebar_backdrop_color ${scheme.withHashtag.base01};
          @define-color secondary_sidebar_shade_color rgba(0, 0, 0, 0.36);
        '';

        gtk4.extraCss = ''
          @define-color accent_color ${scheme.withHashtag.base0D};
          @define-color accent_bg_color ${scheme.withHashtag.base0D};
          @define-color accent_fg_color ${scheme.withHashtag.base00};
          @define-color destructive_color ${scheme.withHashtag.base08};
          @define-color destructive_bg_color ${scheme.withHashtag.base08};
          @define-color destructive_fg_color ${scheme.withHashtag.base00};
          @define-color success_color ${scheme.withHashtag.base0B};
          @define-color success_bg_color ${scheme.withHashtag.base0B};
          @define-color success_fg_color ${scheme.withHashtag.base00};
          @define-color warning_color ${scheme.withHashtag.base0A};
          @define-color warning_bg_color ${scheme.withHashtag.base0A};
          @define-color warning_fg_color ${scheme.withHashtag.base00};
          @define-color error_color ${scheme.withHashtag.base08};
          @define-color error_bg_color ${scheme.withHashtag.base08};
          @define-color error_fg_color ${scheme.withHashtag.base00};
          @define-color window_bg_color ${scheme.withHashtag.base00};
          @define-color window_fg_color ${scheme.withHashtag.base05};
          @define-color view_bg_color ${scheme.withHashtag.base00};
          @define-color view_fg_color ${scheme.withHashtag.base05};
          @define-color headerbar_bg_color ${scheme.withHashtag.base01};
          @define-color headerbar_fg_color ${scheme.withHashtag.base05};
          @define-color headerbar_border_color ${scheme.withHashtag.base00};
          @define-color headerbar_backdrop_color ${scheme.withHashtag.base01};
          @define-color headerbar_shade_color rgba(0, 0, 0, 0.36);
          @define-color card_bg_color ${scheme.withHashtag.base01};
          @define-color card_fg_color ${scheme.withHashtag.base05};
          @define-color card_shade_color rgba(0, 0, 0, 0.36);
          @define-color dialog_bg_color ${scheme.withHashtag.base01};
          @define-color dialog_fg_color ${scheme.withHashtag.base05};
          @define-color popover_bg_color ${scheme.withHashtag.base01};
          @define-color popover_fg_color ${scheme.withHashtag.base05};
          @define-color shade_color rgba(0, 0, 0, 0.36);
          @define-color scrollbar_outline_color ${scheme.withHashtag.base00};
          @define-color sidebar_bg_color ${scheme.withHashtag.base00};
          @define-color sidebar_fg_color ${scheme.withHashtag.base05};
          @define-color sidebar_backdrop_color ${scheme.withHashtag.base01};
          @define-color sidebar_shade_color rgba(0, 0, 0, 0.36);
          @define-color secondary_sidebar_bg_color ${scheme.withHashtag.base00};
          @define-color secondary_sidebar_fg_color ${scheme.withHashtag.base05};
          @define-color secondary_sidebar_backdrop_color ${scheme.withHashtag.base01};
          @define-color secondary_sidebar_shade_color rgba(0, 0, 0, 0.36);
        '';

        gtk3.extraConfig = {
          gtk-application-prefer-dark-theme = theme.polarity == "dark";
        };

        gtk4.extraConfig = {
          gtk-application-prefer-dark-theme = theme.polarity == "dark";
        };
      };
    };
}
