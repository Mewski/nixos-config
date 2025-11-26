{
  flake.homeModules.theme =
    { polarity, ... }:
    {
      programs.zen-browser.profiles.default.settings = {
        "zen.view.window.scheme" = if polarity == "dark" then 0 else 1;
        "layout.css.prefers-color-scheme.content-override" = if polarity == "dark" then 0 else 1;
      };
    };
}
