{
  flake.homeModules.waybar =
    { pkgs, lib, ... }:
    {
      programs.waybar = {
        enable = true;

        settings = {
          mainBar = {
            height = 26;
            margin-top = 6;
            margin-left = 6;
            margin-right = 6;
            spacing = 3;
            modules-left = [
              "custom/power"
              "hyprland/window"
            ];
            modules-center = [ "hyprland/workspaces" ];
            modules-right = [
              "tray"
              "network"
              "bluetooth"
              "pulseaudio"
              "cpu"
              "memory"
              "battery"
              "clock"
            ];

            "custom/power" = {
              format = "";
              on-click = "${lib.getExe pkgs.wlogout}";
              tooltip = false;
            };

            "hyprland/workspaces" = {
              format = "{name}";
              on-scroll-up = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch workspace e+1";
              on-scroll-down = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch workspace e-1";
            };

            "hyprland/window" = {
              format = "{title}";
              max-length = 50;
              separate-outputs = true;
            };

            clock = {
              format = "󰃰 {:%H:%M:%S}";
              format-alt = "󰃰 {:%Y-%m-%d}";
              interval = 1;
              tooltip-format = "<tt><small>{calendar}</small></tt>";
            };

            battery = {
              format = "{icon} {capacity:2}%";
              format-charging = "󰂄 {capacity:2}%";
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
              format = "󰍛 {usage:2}%";
              on-click = "${lib.getExe pkgs.kitty} -e ${lib.getExe pkgs.btop}";
            };

            memory = {
              format = "󰘚 {percentage:2}%";
              on-click = "${lib.getExe pkgs.kitty} -e ${lib.getExe pkgs.btop}";
            };

            tray = {
              spacing = 20;
              icon-size = 10;
            };

            network = {
              format-wifi = "󰖩 {signalStrength:2}%";
              format-ethernet = "󰈀";
              format-disconnected = "󰖪";
              tooltip-format-wifi = "SSID: {essid}\nIP: {ipaddr}/{cidr}\nGateway: {gwaddr}";
              tooltip-format-ethernet = "Interface: {ifname}\nIP: {ipaddr}/{cidr}\nGateway: {gwaddr}";
              tooltip-format-disconnected = "Disconnected";
              on-click = "NEWT_COLORS='root=,black' ${lib.getExe pkgs.kitty} -e ${lib.getExe' pkgs.networkmanager "nmtui"}";
            };

            bluetooth = {
              format = "󰂯";
              format-disabled = "󰂲";
              format-connected = "󰂱 {num_connections}";
              tooltip-format = "Controller: {controller_alias}\nAddress: {controller_address}";
              tooltip-format-connected = "Controller: {controller_alias}\nAddress: {controller_address}\n\n{device_enumerate}";
              tooltip-format-enumerate-connected = "Device: {device_alias}\nAddress: {device_address}";
              on-click = "${lib.getExe' pkgs.blueman "blueman-manager"}";
            };

            pulseaudio = {
              format = "{icon} {volume}%";
              format-muted = "󰖁";
              format-icons = {
                default = [
                  "󰕿"
                  "󰖀"
                  "󰕾"
                ];
              };
              on-click = "${lib.getExe pkgs.pavucontrol}";
            };
          };
        };
      };
    };
}
