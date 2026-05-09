{
  flake.homeModules.niri =
    {
      pkgs,
      scheme,
      theme,
      ...
    }:
    {
      programs.swaylock = {
        enable = true;
        package = pkgs.swaylock;
        settings = {
          image = toString theme.wallpaper;
          scaling = "fill";
          color = scheme.base00;
          font = theme.fonts.sansSerif.name;
          "font-size" = 18;
          "show-failed-attempts" = true;
          "ignore-empty-password" = true;
          "daemonize" = true;
          "indicator-radius" = 120;
          "indicator-thickness" = 8;
          "indicator-idle-visible" = false;
          "disable-caps-lock-text" = true;
          "inside-color" = "${scheme.base00}cc";
          "inside-clear-color" = "${scheme.base0B}33";
          "inside-ver-color" = "${scheme.base0A}33";
          "inside-wrong-color" = "${scheme.base08}33";
          "ring-color" = scheme.base03;
          "ring-clear-color" = scheme.base0B;
          "ring-ver-color" = scheme.base0A;
          "ring-wrong-color" = scheme.base08;
          "key-hl-color" = scheme.base0D;
          "bs-hl-color" = scheme.base08;
          "line-color" = scheme.base00;
          "separator-color" = scheme.base00;
          "text-color" = scheme.base05;
          "text-clear-color" = scheme.base05;
          "text-ver-color" = scheme.base05;
          "text-wrong-color" = scheme.base08;
          "layout-bg-color" = "${scheme.base00}cc";
          "layout-border-color" = scheme.base03;
          "layout-text-color" = scheme.base05;
        };
      };
    };
}
