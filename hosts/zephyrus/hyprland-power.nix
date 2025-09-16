{ pkgs, ... }:

{
  # Script to change Hyprland refresh rate based on power state
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "hyprland-power" ''
      #!/bin/bash

      # Check if running Hyprland
      if ! pgrep -x "Hyprland" > /dev/null; then
        exit 0
      fi

      # Get AC adapter status (1 = plugged in, 0 = on battery)
      AC_STATUS=$(cat /sys/class/power_supply/ADP*/online 2>/dev/null | head -n1)

      # Fallback to ACAD if ADP not found
      if [ -z "$AC_STATUS" ]; then
        AC_STATUS=$(cat /sys/class/power_supply/ACAD/online 2>/dev/null)
      fi

      if [ "$AC_STATUS" = "1" ]; then
        # Plugged in - use high refresh rate
        hyprctl keyword monitor "eDP-1,2560x1600@240,0x0,1.25,vrr,2"
      else
        # On battery - use low refresh rate
        hyprctl keyword monitor "eDP-1,2560x1600@60,0x0,1.25,vrr,2"
      fi
    '')
  ];

  # Systemd service to run on AC adapter state changes
  systemd.services.hyprland-power = {
    description = "Adjust Hyprland refresh rate based on power state";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "hyprland-power-service" ''
        sleep 1

        HYPRLAND_USER=$(ps -eo user,comm | grep -E "Hyprland$" | head -n1 | awk '{print $1}')

        if [ -n "$HYPRLAND_USER" ]; then
          HYPRLAND_SIGNATURE=$(ls /tmp/hypr/ 2>/dev/null | head -n1)

          if [ -n "$HYPRLAND_SIGNATURE" ]; then
            sudo -u "$HYPRLAND_USER" \
              env HYPRLAND_INSTANCE_SIGNATURE="$HYPRLAND_SIGNATURE" \
              hyprland-power
          fi
        fi
      ''}";
    };
  };

  # udev rule to trigger the service on AC adapter changes
  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", ATTR{type}=="Mains", RUN+="${pkgs.systemd}/bin/systemctl start hyprland-power.service"
  '';
}
