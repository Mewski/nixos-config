{ inputs, ... }:
{
  flake.homeModules.hyprpaper = {
    services.hyprpaper = {
      enable = true;

      settings = {
        preload = [ "${inputs.mewski-wallpapers}/Kath.png" ];
        wallpaper = [ ", ${inputs.mewski-wallpapers}/Kath.png" ];
      };
    };
  };
}
