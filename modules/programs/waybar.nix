{
  flake.homeModules.waybar =
    { pkgs, lib, ... }:
    {
      programs.waybar = {
        enable = true;

        settings = {
          mainBar = {
            margin-top = 8;
            margin-left = 8;
            margin-right = 8;
            spacing = 6;
            modules-left = [ "hyprland/workspaces" ];
            modules-center = [ "tray" ];
            modules-right = [
              "network"
              "bluetooth"
              "cpu"
              "memory"
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
              tooltip-format = "<tt><small>{calendar}</small></tt>";
            };

            battery = {
              format = "{icon}  {capacity}%";
              format-charging = "󰂄  {capacity}%";
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

            memory = {
              format = "󰘚  {}%";
            };

            network = {
              format-wifi = "󰖩  {signalStrength}%";
              format-ethernet = "󰈀";
              format-disconnected = "󰖪";
              tooltip-format-wifi = "SSID: {essid}\nIP: {ipaddr}/{cidr}\nGateway: {gwaddr}";
              tooltip-format-ethernet = "Interface: {ifname}\nIP: {ipaddr}/{cidr}\nGateway: {gwaddr}";
              tooltip-format-disconnected = "Disconnected";
              on-click = "${lib.getExe pkgs.kitty} ${lib.getExe' pkgs.networkmanager "nmtui"}";
            };

            bluetooth = {
              format = "󰂯";
              format-disabled = "󰂲";
              format-connected = "󰂱  {num_connections}";
              tooltip-format = "Controller: {controller_alias}\nAddress: {controller_address}";
              tooltip-format-connected = "Controller: {controller_alias}\nAddress: {controller_address}\n\n{device_enumerate}";
              tooltip-format-enumerate-connected = "Device: {device_alias}\nAddress: {device_address}";
              on-click = lib.getExe' pkgs.blueman "blueman-manager";
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
              on-click = lib.getExe' pkgs.pavucontrol "pavucontrol";
            };
          };
        };
      };
    };
}
