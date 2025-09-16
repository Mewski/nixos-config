{ pkgs, ... }:
let
  # Define the hyprland-power script as a derivation
  hyprland-power-script = pkgs.writeShellScriptBin "hyprland-power" ''
    #!/bin/bash

    # Get AC adapter status (1 = plugged in, 0 = on battery)
    AC_STATUS=$(cat /sys/class/power_supply/ACAD/online 2>/dev/null || cat /sys/class/power_supply/ADP1/online 2>/dev/null || cat /sys/class/power_supply/AC/online 2>/dev/null)

    # Debug logging
    logger -t hyprland-power "AC Status: $AC_STATUS"

    if [ "$AC_STATUS" = "1" ]; then
      # Plugged in - use 240Hz
      logger -t hyprland-power "Setting 240Hz (plugged in)"
      ${pkgs.hyprland}/bin/hyprctl keyword monitor "eDP-1,2560x1600@240,0x0,1.25"
    else
      # On battery - use 60Hz for power saving
      logger -t hyprland-power "Setting 60Hz (on battery)"
      ${pkgs.hyprland}/bin/hyprctl keyword monitor "eDP-1,2560x1600@60,0x0,1.25"
    fi

    # Log the result
    RESULT=$?
    logger -t hyprland-power "hyprctl exit code: $RESULT"
  '';
in
{
  # Add the script to system packages
  environment.systemPackages = [ hyprland-power-script ];

  # User systemd service (runs in user context with proper environment)
  systemd.user.services.hyprland-power = {
    description = "Adjust Hyprland refresh rate based on power state";
    wantedBy = [
      "hyprland-session.target"
      "graphical-session.target"
    ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${hyprland-power-script}/bin/hyprland-power";
      RemainAfterExit = false;
    };
    environment = {
      PATH = "${pkgs.hyprland}/bin:${pkgs.coreutils}/bin";
    };
  };

  # System service to trigger the user service
  systemd.services.hyprland-power-trigger = {
    description = "Trigger Hyprland refresh rate adjustment";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "trigger-hyprland-power" ''
        # Find users running Hyprland
        for pid in $(${pkgs.procps}/bin/pgrep -x Hyprland); do
          uid=$(stat -c %u /proc/$pid 2>/dev/null || continue)
          user=$(id -un $uid 2>/dev/null || continue)

          # Trigger the user service
          ${pkgs.systemd}/bin/systemctl --machine=$user@.host --user start hyprland-power.service
        done
      ''}";
    };
  };

  # udev rule to trigger the service on AC adapter changes
  services.udev.extraRules = ''
    # Trigger on AC adapter changes
    SUBSYSTEM=="power_supply", ATTR{type}=="Mains", RUN+="${pkgs.systemd}/bin/systemctl start hyprland-power-trigger.service"

    # Also trigger on initial plug
    ACTION=="add", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", RUN+="${pkgs.systemd}/bin/systemctl start hyprland-power-trigger.service"
    ACTION=="change", SUBSYSTEM=="power_supply", ATTR{type}=="Mains", RUN+="${pkgs.systemd}/bin/systemctl start hyprland-power-trigger.service"
  '';
}
