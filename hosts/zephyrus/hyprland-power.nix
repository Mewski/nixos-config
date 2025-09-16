{ pkgs, ... }:
let
  # Define the hyprland-power script as a derivation
  hyprland-power-script = pkgs.writeShellScriptBin "hyprland-power" ''
    #!/bin/bash
    # Check if running Hyprland
    if ! pgrep -x "Hyprland" > /dev/null; then
      exit 0
    fi

    # Get AC adapter status (1 = plugged in, 0 = on battery)
    AC_STATUS=$(cat /sys/class/power_supply/ACAD/online 2>/dev/null)

    if [ "$AC_STATUS" = "1" ]; then
      # Plugged in - use high refresh rate with VRR
      hyprctl keyword monitor "eDP-1,preferred,0x0,1.25,vrr,2"
    else
      # On battery - use 60Hz for power saving
      hyprctl keyword monitor "eDP-1,2560x1600@60,0x0,1.25"
    fi
  '';
in
{
  # Add the script to system packages
  environment.systemPackages = [ hyprland-power-script ];

  # Systemd service to run on AC adapter state changes
  systemd.services.hyprland-power = {
    description = "Adjust Hyprland refresh rate based on power state";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "hyprland-power-service" ''
        export PATH=${pkgs.procps}/bin:${pkgs.gawk}/bin:${pkgs.coreutils}/bin:${pkgs.sudo}/bin:$PATH
        sleep 1

        # Find the user running Hyprland
        HYPRLAND_USER=$(ps -eo user,comm | grep "Hyprland" | grep -v grep | head -n1 | awk '{print $1}')

        if [ -n "$HYPRLAND_USER" ]; then
          # Get the user's runtime directory
          USER_ID=$(id -u "$HYPRLAND_USER")
          export HYPRLAND_INSTANCE_SIGNATURE=$(ls -t /run/user/$USER_ID/hypr/ 2>/dev/null | grep -v lock | head -n1)

          # Run the script as the Hyprland user
          sudo -u "$HYPRLAND_USER" \
            HYPRLAND_INSTANCE_SIGNATURE="$HYPRLAND_INSTANCE_SIGNATURE" \
            ${hyprland-power-script}/bin/hyprland-power
        fi
      ''}";
    };
  };

  # udev rule to trigger the service on AC adapter changes
  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", ATTR{type}=="Mains", RUN+="${pkgs.systemd}/bin/systemctl start hyprland-power.service"
  '';
}
