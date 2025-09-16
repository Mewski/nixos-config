{ pkgs, ... }:

{
  # Script to change Hyprland refresh rate based on power state
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "hyprland-power" ''
      #!/bin/bash

      echo "Starting hyprland-power script..." > /tmp/hyprland-power.log

      # Check if running Hyprland
      if ! pgrep -x "Hyprland" > /dev/null; then
        echo "Hyprland not running, exiting" >> /tmp/hyprland-power.log
        exit 0
      fi
      echo "Hyprland is running" >> /tmp/hyprland-power.log

      # Get AC adapter status (1 = plugged in, 0 = on battery)
      AC_STATUS=$(cat /sys/class/power_supply/ADP*/online 2>/dev/null | head -n1)

      # Fallback to ACAD if ADP not found
      if [ -z "$AC_STATUS" ]; then
        AC_STATUS=$(cat /sys/class/power_supply/ACAD/online 2>/dev/null)
      fi

      echo "AC Status: $AC_STATUS" >> /tmp/hyprland-power.log
      echo "HYPRLAND_INSTANCE_SIGNATURE: $HYPRLAND_INSTANCE_SIGNATURE" >> /tmp/hyprland-power.log

      if [ "$AC_STATUS" = "1" ]; then
        # Plugged in - use high refresh rate with VRR
        echo "Setting high refresh rate" >> /tmp/hyprland-power.log
        hyprctl keyword monitor "eDP-1,preferred,0x0,1.25,vrr,2" >> /tmp/hyprland-power.log 2>&1
      else
        # On battery - use 60Hz for power saving
        echo "Setting 60Hz refresh rate" >> /tmp/hyprland-power.log
        hyprctl keyword monitor "eDP-1,2560x1600@60,0x0,1.25" >> /tmp/hyprland-power.log 2>&1
      fi
    '')
  ];

  # Systemd service to run on AC adapter state changes
  systemd.services.hyprland-power = {
    description = "Adjust Hyprland refresh rate based on power state";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "hyprland-power-service" ''
        export PATH=${pkgs.procps}/bin:${pkgs.gawk}/bin:${pkgs.coreutils}/bin:${pkgs.sudo}/bin:$PATH

        echo "Service started at $(date)" > /tmp/hyprland-power-service.log
        sleep 1

        HYPRLAND_USER=$(ps -eo user,comm | grep -E "Hyprland$" | head -n1 | awk '{print $1}')
        echo "Found Hyprland user: $HYPRLAND_USER" >> /tmp/hyprland-power-service.log

        if [ -n "$HYPRLAND_USER" ]; then
          HYPRLAND_SIGNATURE=$(ls /tmp/hypr/ 2>/dev/null | head -n1)
          echo "Found Hyprland signature: $HYPRLAND_SIGNATURE" >> /tmp/hyprland-power-service.log

          if [ -n "$HYPRLAND_SIGNATURE" ]; then
            echo "Running hyprland-power as user $HYPRLAND_USER" >> /tmp/hyprland-power-service.log
            sudo -u "$HYPRLAND_USER" \
              env HYPRLAND_INSTANCE_SIGNATURE="$HYPRLAND_SIGNATURE" \
              hyprland-power
          else
            echo "No Hyprland signature found" >> /tmp/hyprland-power-service.log
          fi
        else
          echo "No Hyprland user found" >> /tmp/hyprland-power-service.log
        fi
      ''}";
    };
  };

  # udev rule to trigger the service on AC adapter changes
  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", ATTR{type}=="Mains", RUN+="${pkgs.systemd}/bin/systemctl start hyprland-power.service"
  '';
}
