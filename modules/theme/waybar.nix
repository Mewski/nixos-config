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
          color: ${scheme.withHashtag.base05};
        }

        tooltip {
          background: ${scheme.withHashtag.base00};
          border: 1px solid ${scheme.withHashtag.base03};
          border-radius: 8px;
          color: ${scheme.withHashtag.base05};
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
          color: ${scheme.withHashtag.base05};
          padding: 0 6px;
          border-radius: 4px;
          margin: 0 2px;
        }

        #workspaces button:hover {
          background: ${scheme.withHashtag.base02};
          box-shadow: none;
        }

        #workspaces button.active {
          background: ${scheme.withHashtag.base0D};
          color: ${scheme.withHashtag.base00};
        }

        #workspaces button.urgent {
          background: ${scheme.withHashtag.base08};
          color: ${scheme.withHashtag.base00};
        }

        #clock {
          color: ${scheme.withHashtag.base0D};
        }

        #battery {
          color: ${scheme.withHashtag.base0B};
        }

        #battery.charging {
          color: ${scheme.withHashtag.base0C};
        }

        #battery.warning:not(.charging) {
          color: ${scheme.withHashtag.base0A};
        }

        #battery.critical:not(.charging) {
          color: ${scheme.withHashtag.base08};
        }

        #cpu {
          color: ${scheme.withHashtag.base0A};
        }

        #memory {
          color: ${scheme.withHashtag.base09};
        }

        #network {
          color: ${scheme.withHashtag.base0C};
        }

        #network.disconnected {
          color: ${scheme.withHashtag.base03};
        }

        #bluetooth {
          color: ${scheme.withHashtag.base0D};
        }

        #bluetooth.disabled {
          color: ${scheme.withHashtag.base03};
        }

        #pulseaudio {
          color: ${scheme.withHashtag.base0E};
        }

        #pulseaudio.muted {
          color: ${scheme.withHashtag.base03};
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
