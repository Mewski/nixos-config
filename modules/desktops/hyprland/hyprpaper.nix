{
  flake.homeModules.hyprpaper =
    { theme, ... }:
    {
      services.hyprpaper = {
        enable = true;
        settings.wallpaper = [
          {
            monitor = "";
            path = toString theme.wallpaper;
          }
        ];
      };
    };
}
