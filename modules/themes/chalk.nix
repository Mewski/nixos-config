{ inputs, ... }:
{
  flake.nixosModules.chalk =
    { pkgs, ... }:
    {
      imports = [
        inputs.base16.nixosModule
      ];

      config = {
        scheme = {
          slug = "chalk";
          scheme = "Chalk";
          author = "FredHappyface";
          polarity = "dark";
          base00 = "151515";
          base01 = "202020";
          base02 = "303030";
          base03 = "505050";
          base04 = "b0b0b0";
          base05 = "d0d0d0";
          base06 = "e0e0e0";
          base07 = "f5f5f5";
          base08 = "fa859c";
          base09 = "ea9971";
          base0A = "ddb26f";
          base0B = "a1bb54";
          base0C = "10bcad";
          base0D = "5ab9ed";
          base0E = "db8fea";
          base0F = "deaf8f";
          base10 = "0b0b0b";
          base11 = "060606";
          base12 = "fb9fb1";
          base13 = "eda987";
          base14 = "acc267";
          base15 = "12cfc0";
          base16 = "6fc2ef";
          base17 = "e1a3ee";
        };

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
