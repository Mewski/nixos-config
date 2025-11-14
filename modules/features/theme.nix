{ inputs, ... }:
{
  flake.nixosModules.theme =
    { config, pkgs, ... }:
    {
      imports = [
        inputs.base16.nixosModule
      ];

      config = {
        scheme = "${inputs.tinted-theming-schemes}/base24/${config.preferences.theme}.yaml";

        cursor = {
          name = "Bibata-Modern-Ice";
          package = pkgs.bibata-cursors;
          size = 24;
        };

        fonts = {
          emoji = {
            name = "Noto Color Emoji";
            package = pkgs.noto-fonts-emoji;
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
          terminal = 0.8;
          popups = 1.0;
        };
      };
    };
}
