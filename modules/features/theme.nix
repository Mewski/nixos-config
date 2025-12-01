{ inputs, ... }:
{
  flake.nixosModules.theme =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [ inputs.base16.nixosModule ];

      options = {
        polarity = lib.mkOption {
          type = lib.types.enum [
            "dark"
            "light"
          ];
          default = "dark";
        };

        cursor = {
          name = lib.mkOption {
            type = lib.types.str;
            default = "Bibata-Modern-Ice";
          };

          package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.bibata-cursors;
          };

          size = lib.mkOption {
            type = lib.types.int;
            default = 24;
          };
        };

        fonts = {
          emoji = {
            name = lib.mkOption {
              type = lib.types.str;
              default = "Noto Color Emoji";
            };

            package = lib.mkOption {
              type = lib.types.package;
              default = pkgs.noto-fonts-color-emoji;
            };
          };

          monospace = {
            name = lib.mkOption {
              type = lib.types.str;
              default = "FiraCode Nerd Font Mono";
            };

            package = lib.mkOption {
              type = lib.types.package;
              default = pkgs.nerd-fonts.fira-code;
            };
          };

          sansSerif = {
            name = lib.mkOption {
              type = lib.types.str;
              default = "Inter";
            };

            package = lib.mkOption {
              type = lib.types.package;
              default = pkgs.inter;
            };
          };

          serif = {
            name = lib.mkOption {
              type = lib.types.str;
              default = "Source Serif Pro";
            };

            package = lib.mkOption {
              type = lib.types.package;
              default = pkgs.source-serif;
            };
          };

          sizes = {
            desktop = lib.mkOption {
              type = lib.types.int;
              default = 10;
            };

            application = lib.mkOption {
              type = lib.types.int;
              default = 12;
            };

            terminal = lib.mkOption {
              type = lib.types.int;
              default = 12;
            };

            popups = lib.mkOption {
              type = lib.types.int;
              default = 10;
            };
          };
        };

        opacity = {
          desktop = lib.mkOption {
            type = lib.types.float;
            default = 0.8;
          };

          application = lib.mkOption {
            type = lib.types.float;
            default = 1.0;
          };

          terminal = lib.mkOption {
            type = lib.types.float;
            default = 0.8;
          };

          popups = lib.mkOption {
            type = lib.types.float;
            default = 1.0;
          };
        };
      };

      config = {
        scheme = "${inputs.tinted-theming-schemes}/base24/${config.preferences.theme}.yaml";

        environment.variables.XCURSOR_SIZE = toString config.cursor.size;

        fonts.packages = with pkgs; [
          config.fonts.emoji.package
          config.fonts.monospace.package
          config.fonts.sansSerif.package
          config.fonts.serif.package

          noto-fonts
        ];
      };
    };

  flake.homeModules.theme =
    { cursor, ... }:
    {
      home.pointerCursor = {
        name = cursor.name;
        package = cursor.package;
        size = cursor.size;
        x11.enable = true;
        gtk.enable = true;
      };
    };
}
