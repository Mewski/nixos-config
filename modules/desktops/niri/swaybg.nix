{
  flake.homeModules.niri =
    { theme, ... }:
    {
      services.swaybg = {
        enable = true;
        image = toString theme.wallpaper;
      };
    };
}
