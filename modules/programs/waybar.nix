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
            spacing = 4;
            modules-left = [ "hyprland/workspaces" ];
            modules-center = [ "hyprland/window" ];
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

            "hyprland/workspaces" = {
              format = "{name}";
              on-scroll-up = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch workspace e+1";
              on-scroll-down = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch workspace e-1";
            };

            "hyprland/window" = {
              format = "{title}";
              max-length = 50;
              separate-outputs = true;
              icon = true;
              icon-size = 16;
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
              on-click = "${lib.getExe pkgs.kitty} -e ${lib.getExe pkgs.btop}";
            };

            memory = {
              format = "󰘚  {}%";
              on-click = "${lib.getExe pkgs.kitty} -e ${lib.getExe pkgs.btop}";
            };

            network = {
              format-wifi = "󰖩  {signalStrength}%";
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
              format-connected = "󰂱  {num_connections}";
              tooltip-format = "Controller: {controller_alias}\nAddress: {controller_address}";
              tooltip-format-connected = "Controller: {controller_alias}\nAddress: {controller_address}\n\n{device_enumerate}";
              tooltip-format-enumerate-connected = "Device: {device_alias}\nAddress: {device_address}";
              on-click = "${lib.getExe' pkgs.blueman "blueman-manager"}";
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
              on-click = "${lib.getExe pkgs.pavucontrol}";
            };
          };
        };
      };
    };
}
