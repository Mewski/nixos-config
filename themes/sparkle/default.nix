{ pkgs, ... }:

{
  # Colorscheme
  stylix.base16Scheme = {
    base00 = "38191a";
    base01 = "593d3f";
    base02 = "796163";
    base03 = "9a8588";
    base04 = "baa8ad";
    base05 = "dbccd1";
    base06 = "e0d4d8";
    base07 = "e5dbdf";
    base08 = "a96188";
    base09 = "996e67";
    base0A = "d44646";
    base0B = "877470";
    base0C = "b753a4";
    base0D = "ad6369";
    base0E = "e4a1c5";
    base0F = "e1c5d0";
  };

  # Wallpaper
  stylix.image = ./wallpapers/wall2.png;

  # Polarity
  stylix.polarity = "dark";

  # Cursor
  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
}
