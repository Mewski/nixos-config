{
  flake.homeModules.theme =
    { polarity, ... }:
    {
      programs.zen-browser.profiles.default.settings = {
        "zen.widget.linux.transparency" = true;
        "zen.view.grey-out-inactive-windows" = false;
        "zen.theme.content-element-separation" = 0;
        "zen.view.window.scheme" = if polarity == "dark" then 0 else 1;
        "layout.css.prefers-color-scheme.content-override" = if polarity == "dark" then 0 else 1;
      };
    };
}
