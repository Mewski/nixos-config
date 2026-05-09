{
  flake.homeModules.niri =
    {
      config,
      lib,
      pkgs,
      scheme,
      theme,
      ...
    }:
    let
      rawEffectsConfig = ''

        blur {
            passes 5
            offset 5.0
            noise 0.02
            saturation 1.5
        }

        window-rule {
            geometry-corner-radius ${toString theme.rounding}
            clip-to-geometry true
            draw-border-with-background false

            background-effect {
                blur true
                xray false
                noise 0.02
                saturation 1.5
            }

            popups {
                geometry-corner-radius ${toString theme.rounding}
                background-effect {
                    blur true
                    xray false
                    noise 0.02
                    saturation 1.5
                }
            }
        }

        layer-rule {
            match namespace="^(waybar|rofi|notifications)$"
            geometry-corner-radius ${toString theme.rounding}

            background-effect {
                blur true
                xray false
                noise 0.02
                saturation 1.5
            }

            popups {
                geometry-corner-radius ${toString theme.rounding}
                background-effect {
                    blur true
                    xray false
                    noise 0.02
                    saturation 1.5
                }
            }
        }
      '';

      niriConfig = pkgs.writeText "niri-config.kdl" ''
        ${config.programs.niri.finalConfig}
        ${rawEffectsConfig}
      '';
    in
    {
      xdg.configFile.niri-config.source = lib.mkForce (
        pkgs.runCommand "niri-config-validated.kdl" { } ''
          ${lib.getExe config.programs.niri.package} validate --config ${niriConfig}
          cp ${niriConfig} $out
        ''
      );

      programs.niri.settings = {
        layout = {
          background-color = "#${scheme.base00}";
          gaps = theme.gap;
          border = {
            enable = true;
            width = 2;
          };
          focus-ring.enable = false;
          shadow.enable = false;
          tab-indicator = {
            hide-when-single-tab = true;
            place-within-column = true;
            gap = 4;
            width = 4;
            position = "right";
            gaps-between-tabs = 2;
            corner-radius = theme.rounding;
          };
        };

        overview = {
          backdrop-color = "#${scheme.base00}";
          workspace-shadow.enable = false;
        };

        animations.enable = true;
      };
    };
}
