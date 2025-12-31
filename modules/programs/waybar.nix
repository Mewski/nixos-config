{
  flake.homeModules.waybar =
    { lib, pkgs, ... }:
    let
      hyprctl = lib.getExe' pkgs.hyprland "hyprctl";
      kitty = lib.getExe pkgs.kitty;
      btop = lib.getExe pkgs.btop;
    in
    {
      programs.waybar = {
        enable = true;

        settings.mainBar = {
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
            "privacy"
            "idle_inhibitor"
            "bluetooth"
            "network"
            "pulseaudio"
            "cpu"
            "memory"
            "battery"
            "clock"
          ];

          "custom/power" = {
            format = "";
            on-click = lib.getExe pkgs.wlogout;
            tooltip = false;
          };

          "hyprland/workspaces" = {
            format = "{name}";
            on-scroll-down = "${hyprctl} dispatch workspace e+1";
            on-scroll-up = "${hyprctl} dispatch workspace e-1";
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
            format = "󰍛 {usage}%";
            on-click = "${kitty} -e ${btop}";
          };

          memory = {
            format = "󰘚 {percentage}%";
            on-click = "${kitty} -e ${btop}";
          };

          tray = {
            spacing = 12;
            icon-size = 10;
            show-passive-items = true;
          };

          network = {
            format-wifi = "󰖩 {signalStrength}%";
            format-ethernet = "󰈀";
            format-disconnected = "󰖪";
            tooltip-format-wifi = "SSID: {essid}\nIP: {ipaddr}/{cidr}\nGateway: {gwaddr}";
            tooltip-format-ethernet = "Interface: {ifname}\nIP: {ipaddr}/{cidr}\nGateway: {gwaddr}";
            tooltip-format-disconnected = "Disconnected";
            on-click = "NEWT_COLORS='root=,black' ${kitty} -e ${lib.getExe' pkgs.networkmanager "nmtui"}";
          };

          bluetooth = {
            format = "󰂯";
            format-disabled = "󰂲";
            format-connected = "󰂱 {num_connections}";
            tooltip-format = "Controller: {controller_alias}\nAddress: {controller_address}";
            tooltip-format-connected = "Controller: {controller_alias}\nAddress: {controller_address}\n\n{device_enumerate}";
            tooltip-format-enumerate-connected = "Device: {device_alias}\nAddress: {device_address}";
            on-click = lib.getExe' pkgs.blueman "blueman-manager";
          };

          pulseaudio = {
            format = "{icon} {volume}%";
            format-muted = "󰖁";
            format-icons.default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
            on-click = lib.getExe pkgs.pavucontrol;
          };

          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "󰈈";
              deactivated = "󰈉";
            };
            tooltip-format-activated = "Idle inhibitor active";
            tooltip-format-deactivated = "Idle inhibitor inactive";
          };

          privacy = {
            icon-spacing = 12;
            icon-size = 10;
            transition-duration = 250;
            modules = [
              {
                type = "screenshare";
                tooltip = true;
                "tooltip-icon-size" = 10;
              }
              {
                type = "audio-in";
                tooltip = true;
                "tooltip-icon-size" = 10;
              }
            ];
          };
        };
      };
    };
}
