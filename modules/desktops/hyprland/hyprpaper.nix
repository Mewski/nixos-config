{
  flake.homeModules.hyprland =
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
