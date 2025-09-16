{ pkgs, ... }:
let
  hyprland-power = pkgs.writeShellScriptBin "hyprland-power" ''
    #!/usr/bin/env bash
    set -euo pipefail

    # Host-specific AC path
    AC_PATH="/sys/class/power_supply/ACAD/online"

    # Exit quietly if the path isn't present (just in case)
    [[ -r "$AC_PATH" ]] || exit 0

    read -r AC < "$AC_PATH"

    if [[ "$AC" == "1" ]]; then
      hyprctl keyword monitor "eDP-1,2560x1600@240,0x0,1.25"
    else
      hyprctl keyword monitor "eDP-1,2560x1600@60,0x0,1.25"
    fi
  '';
in
{
  environment.systemPackages = [ hyprland-power ];

  # User service: runs in your session so hyprctl can talk to Hyprland
  systemd.user.services.hyprland-power = {
    description = "Change refresh rate on power state (host-specific)";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${hyprland-power}/bin/hyprland-power";
    };
    # Provide hyprctl and bash to the unit's PATH
    path = [
      pkgs.hyprland
      pkgs.bash
    ];
    # Optional: run once at session start to sync the initial state
    wantedBy = [
      "graphical-session.target"
      "default.target"
    ];
  };

  # Fire the service whenever ACAD/online changes
  systemd.user.paths.hyprland-power = {
    description = "Watch ACAD online status";
    pathConfig = {
      PathChanged = "/sys/class/power_supply/ACAD/online";
      Unit = "hyprland-power.service";
    };
    wantedBy = [ "default.target" ];
  };
}
