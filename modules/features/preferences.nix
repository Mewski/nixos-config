{ inputs, ... }:
{
  flake.nixosModules.preferences =
    { config, pkgs, ... }:
    {
      preferences = {
        user = {
          username = "mewski";
          name = "Mewski";
        };
        theme = "mountain";
      };

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
          desktop = 1.0;
          application = 1.0;
          terminal = 1.0;
          popups = 1.0;
        };
      };

      scheme = "${inputs.tinted-theming-schemes}/base24/${config.preferences.theme}.yaml";

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
