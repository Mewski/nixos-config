{
  flake.homeModules.theme =
    {
      fonts,
      scheme,
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

        #workspaces,
        #window,
        #clock,
        #battery,
        #cpu,
        #memory,
        #disk,
        #temperature,
        #backlight,
        #network,
        #pulseaudio,
        #wireplumber,
        #tray,
        #mode,
        #idle_inhibitor,
        #mpd,
        #custom-media,
        #custom-power {
          background: #${scheme.base01};
          padding: 4px 12px;
          border-radius: 12px;
        }

        #workspaces {
          padding: 4px 6px;
        }

        #workspaces button {
          background: transparent;
          color: #${scheme.base05};
          padding: 0 6px;
          border-radius: 8px;
          margin: 0;
        }

        #workspaces button:hover {
          background: #${scheme.base02};
        }

        #workspaces button.active {
          background: #${scheme.base0D};
          color: #${scheme.base00};
        }

        #workspaces button.urgent {
          background: #${scheme.base08};
          color: #${scheme.base00};
        }

        #window {
          color: #${scheme.base05};
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
          color: #${scheme.base0A};
        }

        #disk {
          color: #${scheme.base0C};
        }

        #temperature {
          color: #${scheme.base0B};
        }

        #temperature.critical {
          color: #${scheme.base08};
        }

        #backlight {
          color: #${scheme.base0A};
        }

        #network {
          color: #${scheme.base0D};
        }

        #network.disconnected {
          color: #${scheme.base08};
        }

        #pulseaudio,
        #wireplumber {
          color: #${scheme.base0E};
        }

        #pulseaudio.muted,
        #wireplumber.muted {
          color: #${scheme.base03};
        }

        #tray {
          padding: 4px 8px;
        }

        #tray > .passive {
          -gtk-icon-effect: dim;
        }

        #tray > .needs-attention {
          -gtk-icon-effect: highlight;
        }

        #idle_inhibitor {
          color: #${scheme.base0C};
        }

        #idle_inhibitor.activated {
          color: #${scheme.base08};
        }

        #mode {
          background: #${scheme.base0A};
          color: #${scheme.base00};
        }

        #mpd,
        #custom-media {
          color: #${scheme.base0B};
        }
      '';
    };
}
