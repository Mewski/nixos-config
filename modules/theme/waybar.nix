{
  flake.homeModules.theme =
    {
      fonts,
      scheme,
      opacity,
      ...
    }:
    {
      programs.waybar.style = ''
        * {
          font-family: "${fonts.sansSerif.name}";
          font-size: ${toString fonts.sizes.desktop}pt;
          border: none;
          border-radius: 0;
          min-height: 0;
          text-shadow: none;
        }

        window#waybar {
          background: transparent;
          color: #${scheme.base05};
        }

        tooltip {
          background: #${scheme.base00};
          border: 1px solid #${scheme.base03};
          border-radius: 8px;
          color: #${scheme.base05};
        }

        .modules-left,
        .modules-center,
        .modules-right {
          background: transparent;
        }

        .modules-left > widget,
        .modules-center > widget,
        .modules-right > widget {
          margin: 0 4px;
        }

        #window,
        #clock,
        #battery,
        #cpu,
        #memory,
        #network,
        #bluetooth,
        #pulseaudio,
        #tray {
          background: rgba(${scheme.base00-rgb-r}, ${scheme.base00-rgb-g}, ${scheme.base00-rgb-b}, ${toString opacity.desktop});
          padding: 4px 12px;
          border-radius: 8px;
        }

        #workspaces {
          background: rgba(${scheme.base00-rgb-r}, ${scheme.base00-rgb-g}, ${scheme.base00-rgb-b}, ${toString opacity.desktop});
          padding: 4px 2px;
          border-radius: 8px;
        }

        #workspaces button {
          background: transparent;
          color: #${scheme.base05};
          padding: 0 6px;
          border-radius: 4px;
          margin: 0 2px;
        }

        #workspaces button:hover {
          background: #${scheme.base02};
          box-shadow: none;
        }

        #workspaces button.active {
          background: #${scheme.base0D};
          color: #${scheme.base00};
        }

        #workspaces button.urgent {
          background: #${scheme.base08};
          color: #${scheme.base00};
        }

        #clock {
          color: #${scheme.base0D};
        }

        #battery {
          color: #${scheme.base0B};
        }

        #battery.charging {
          color: #${scheme.base0C};
        }

        #battery.warning:not(.charging) {
          color: #${scheme.base0A};
        }

        #battery.critical:not(.charging) {
          color: #${scheme.base08};
        }

        #cpu {
          color: #${scheme.base0A};
        }

        #memory {
          color: #${scheme.base09};
        }

        #network {
          color: #${scheme.base0C};
        }

        #network.disconnected {
          color: #${scheme.base03};
        }

        #bluetooth {
          color: #${scheme.base0D};
        }

        #bluetooth.disabled {
          color: #${scheme.base03};
        }

        #pulseaudio {
          color: #${scheme.base0E};
        }

        #pulseaudio.muted {
          color: #${scheme.base03};
        }

        #tray {
          padding: 4px 8px;
        }

        window#waybar.empty #window {
          background: transparent;
          padding: 0;
          margin: 0;
          border: 0;
          min-width: 0;
        }
      '';
    };
}
