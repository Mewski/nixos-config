{
  flake.homeModules.waybar =
    { theme, scheme, ... }:
    {
      programs.waybar.style = ''
        * {
          font-family: "${theme.fonts.monospace.name}";
          font-size: ${toString theme.fonts.sizes.desktop}pt;
          border: none;
          border-radius: 0;
          min-height: 0;
          text-shadow: none;
        }

        label, image {
          margin-top: 1px;
          margin-bottom: -1px;
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

        .modules-left {
          background: rgba(${scheme.base00-rgb-r}, ${scheme.base00-rgb-g}, ${scheme.base00-rgb-b}, ${toString theme.opacity.desktop});
          border-radius: 8px;
          padding: 0 4px;
        }

        .modules-center {
          background: transparent;
        }

        .modules-right {
          background: rgba(${scheme.base00-rgb-r}, ${scheme.base00-rgb-g}, ${scheme.base00-rgb-b}, ${toString theme.opacity.desktop});
          border-radius: 8px;
          padding: 0 4px;
        }

        .modules-left > widget,
        .modules-center > widget {
          margin: 0 4px;
        }

        #window {
          background: transparent;
          padding: 4px 8px;
        }

        #battery,
        #cpu,
        #memory,
        #network,
        #bluetooth,
        #pulseaudio,
        #clock,
        #tray {
          background: transparent;
          padding: 4px 8px;
        }

        #workspaces {
          background: rgba(${scheme.base00-rgb-r}, ${scheme.base00-rgb-g}, ${scheme.base00-rgb-b}, ${toString theme.opacity.desktop});
          border-radius: 8px;
          padding: 4px;
        }

        #workspaces button {
          background: transparent;
          color: ${scheme.withHashtag.base05};
          padding: 0px 6px;
          margin-left: 4px;
          border-radius: 4px;
          box-shadow: none;
        }

        #workspaces button:first-child {
          margin-left: 0;
        }

        #workspaces button:hover {
          background: ${scheme.withHashtag.base02};
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

        #idle_inhibitor {
          background: transparent;
          padding: 4px 8px;
          color: ${scheme.withHashtag.base03};
        }

        #idle_inhibitor.activated {
          color: ${scheme.withHashtag.base0A};
        }

        #privacy {
          background: transparent;
          padding: 4px 4px;
        }

        #privacy-item {
          padding: 0 2px;
        }

        #privacy-item.screenshare {
          color: ${scheme.withHashtag.base0B};
        }

        #privacy-item.audio-in {
          color: ${scheme.withHashtag.base08};
        }

        #custom-power {
          background: transparent;
          font-size: 22px;
          margin-top: -11px;
          margin-bottom: -11px;
          padding: 0 2px 0 3px;
          color: ${scheme.withHashtag.base0D};
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
