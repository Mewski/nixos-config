{ inputs, ... }:
{
  flake.nixosModules.zephyrus =
    { config, pkgs, ... }:
    {
      scheme = "${inputs.tinted-theming-schemes}/base24/mountain.yaml";

      theme = {
        polarity = "dark";

        cursor = {
          name = "Bibata-Modern-Ice";
          package = pkgs.bibata-cursors;
          size = 24;
        };

        fonts = {
          emoji = {
            name = "Noto Color Emoji";
            package = pkgs.noto-fonts-color-emoji;
          };
          monospace = {
            name = "FiraCode Nerd Font Mono";
            package = pkgs.nerd-fonts.fira-code;
          };
          sansSerif = {
            name = "Inter";
            package = pkgs.inter;
          };
          serif = {
            name = "Source Serif Pro";
            package = pkgs.source-serif;
          };
          sizes = {
            desktop = 10;
            application = 12;
            terminal = 12;
            popups = 10;
          };
        };

        opacity = {
          desktop = 0.8;
          application = 0.8;
          terminal = 0.8;
          popups = 0.8;
        };
      };

      fonts.packages = with pkgs; [
        config.theme.fonts.emoji.package
        config.theme.fonts.monospace.package
        config.theme.fonts.sansSerif.package
        config.theme.fonts.serif.package
        noto-fonts
        corefonts
        vista-fonts
        liberation_ttf
      ];
    };
}
