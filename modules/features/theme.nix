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
      imports = [
        inputs.base16.nixosModule
      ];

      options = {
        polarity = lib.mkOption {
          type = lib.types.enum [
            "dark"
            "light"
          ];
          default = "dark";
          description = "Theme polarity (dark or light)";
        };

        cursor = {
          name = lib.mkOption {
            type = lib.types.str;
            default = "Bibata-Modern-Ice";
            description = "Cursor theme name";
          };
          package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.bibata-cursors;
            description = "Cursor theme package";
          };
          size = lib.mkOption {
            type = lib.types.int;
            default = 24;
            description = "Cursor size in pixels";
          };
        };

        fonts = {
          emoji = {
            name = lib.mkOption {
              type = lib.types.str;
              default = "Noto Color Emoji";
              description = "Emoji font name";
            };
            package = lib.mkOption {
              type = lib.types.package;
              default = pkgs.noto-fonts-emoji;
              description = "Emoji font package";
            };
          };

          monospace = {
            name = lib.mkOption {
              type = lib.types.str;
              default = "FiraCode Nerd Font Mono";
              description = "Monospace font name";
            };
            package = lib.mkOption {
              type = lib.types.package;
              default = pkgs.nerd-fonts.fira-code;
              description = "Monospace font package";
            };
          };

          sansSerif = {
            name = lib.mkOption {
              type = lib.types.str;
              default = "Inter";
              description = "Sans-serif font name";
            };
            package = lib.mkOption {
              type = lib.types.package;
              default = pkgs.inter;
              description = "Sans-serif font package";
            };
          };

          serif = {
            name = lib.mkOption {
              type = lib.types.str;
              default = "Source Serif Pro";
              description = "Serif font name";
            };
            package = lib.mkOption {
              type = lib.types.package;
              default = pkgs.source-serif;
              description = "Serif font package";
            };
          };

          sizes = {
            desktop = lib.mkOption {
              type = lib.types.int;
              default = 10;
              description = "Font size for desktop UI elements";
            };
            application = lib.mkOption {
              type = lib.types.int;
              default = 12;
              description = "Font size for application content";
            };
            terminal = lib.mkOption {
              type = lib.types.int;
              default = 12;
              description = "Font size for terminal emulators";
            };
            popups = lib.mkOption {
              type = lib.types.int;
              default = 10;
              description = "Font size for popup windows";
            };
          };
        };

        opacity = {
          desktop = lib.mkOption {
            type = lib.types.float;
            default = 1.0;
            description = "Opacity for desktop background (0.0-1.0)";
          };
          application = lib.mkOption {
            type = lib.types.float;
            default = 1.0;
            description = "Opacity for application windows (0.0-1.0)";
          };
          terminal = lib.mkOption {
            type = lib.types.float;
            default = 0.8;
            description = "Opacity for terminal windows (0.0-1.0)";
          };
          popups = lib.mkOption {
            type = lib.types.float;
            default = 1.0;
            description = "Opacity for popup windows (0.0-1.0)";
          };
        };
      };

      config.scheme = "${inputs.tinted-theming-schemes}/base24/${config.preferences.theme}.yaml";
    };
}
