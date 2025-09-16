{ pkgs, ... }:
{
  # Simple udev rule that directly executes the power management
  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", ATTR{type}=="Mains", RUN+="${pkgs.writeShellScript "hyprland-power" ''
      #!/bin/sh

      # Get AC status
      AC_STATUS=$(cat /sys/class/power_supply/ACAD/online 2>/dev/null || echo "0")

      # Find Hyprland PID and user
      HYPR_PID=$(${pkgs.procps}/bin/pgrep -x Hyprland | head -n1)
      [ -z "$HYPR_PID" ] && exit 0

      # Get user ID and name
      HYPR_UID=$(stat -c %u /proc/$HYPR_PID 2>/dev/null)
      [ -z "$HYPR_UID" ] && exit 0
      HYPR_USER=$(id -un $HYPR_UID 2>/dev/null)

      # Get Hyprland instance signature
      HYPR_SIG=$(ls -t /run/user/$HYPR_UID/hypr/ 2>/dev/null | grep -v lock | head -n1)
      [ -z "$HYPR_SIG" ] && exit 0

      # Set refresh rate based on power state
      if [ "$AC_STATUS" = "1" ]; then
        MONITOR_CMD="eDP-1,2560x1600@240,0x0,1.25"
      else
        MONITOR_CMD="eDP-1,2560x1600@60,0x0,1.25"
      fi

      # Execute as the Hyprland user with proper environment
      su - $HYPR_USER -c "HYPRLAND_INSTANCE_SIGNATURE=$HYPR_SIG ${pkgs.hyprland}/bin/hyprctl keyword monitor '$MONITOR_CMD'" 2>/dev/null
    ''}"
  '';
}
