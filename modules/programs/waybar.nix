{
  flake.homeModules.waybar =
    { pkgs, ... }:
    {
      programs.waybar = {
        enable = true;
        settings = {
          mainBar = {
            margin-top = 8;
            margin-left = 8;
            margin-right = 8;
            spacing = 5;
            modules-left = [ "hyprland/workspaces" ];
            modules-center = [ "tray" ];
            modules-right = [
              "network"
              "cpu"
              "pulseaudio"
              "battery"
              "clock"
            ];

            "hyprland/workspaces" = {
              format = "{name}";
              on-scroll-up = "hyprctl dispatch workspace e+1";
              on-scroll-down = "hyprctl dispatch workspace e-1";
            };

            clock = {
              format = "󰃰  {:%H:%M:%S}";
              format-alt = "󰃰  {:%Y-%m-%d}";
              interval = 1;
              tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            };

            battery = {
              format = "{icon} {capacity}%";
              format-charging = "󰂄 {capacity}%";
              format-icons = [
                "󰂃"
                "󰁺"
                "󰁻"
                "󰁼"
                "󰁽"
                "󰁾"
                "󰁿"
                "󰂀"
                "󰂁"
                "󰂂"
                "󰁹"
              ];
            };

            cpu = {
              format = "󰍛  {usage}%";
            };

            network = {
              format-wifi = "󰖩  {signalStrength}%";
              format-ethernet = "󰈀";
              format-disconnected = "󰖪";
              tooltip-format-wifi = "{essid}\n{ipaddr}/{cidr}\nGateway: {gwaddr}";
              tooltip-format-ethernet = "{ifname}\n{ipaddr}/{cidr}";
              tooltip-format-disconnected = "Disconnected";
            };

            pulseaudio = {
              format = "{icon}  {volume}%";
              format-muted = "󰖁";
              format-icons = {
                default = [
                  "󰕿"
                  "󰖀"
                  "󰕾"
                ];
              };
              on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
            };
          };
        };
      };
    };
}
