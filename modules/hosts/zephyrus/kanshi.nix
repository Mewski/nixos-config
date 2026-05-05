{ inputs, ... }:
{
  flake.homeModules.zephyrus =
    { lib, pkgs, ... }:
    let
      laptop = rate: {
        criteria = "eDP-1";
        mode = "2560x1600@${rate}";
        position = "0,0";
        scale = 1.25;
      };

      external = rate: {
        criteria = "DP-1";
        mode = "2560x1600@${rate}";
        position = "2048,0";
        scale = 1.25;
      };

      mkProfile = name: outputs: { profile = { inherit name outputs; }; };

      hyprlandPkg = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    in
    {
      services.kanshi = {
        enable = true;
        systemdTarget = "graphical-session.target";
        settings = [
          (mkProfile "undocked-ac" [ (laptop "240Hz") ])
          (mkProfile "undocked-battery" [ (laptop "60Hz") ])
          (mkProfile "docked-dp-ac" [
            (laptop "240Hz")
            (external "144Hz")
          ])
          (mkProfile "docked-dp-battery" [
            (laptop "60Hz")
            (external "60Hz")
          ])
        ];
      };

      systemd.user.services.kanshi-power-switcher = {
        Unit = {
          Description = "Switch kanshi profile based on AC power and dock state";
          PartOf = [ "graphical-session.target" ];
          After = [ "kanshi.service" ];
          BindsTo = [ "kanshi.service" ];
        };
        Install.WantedBy = [ "kanshi.service" ];
        Service = {
          Type = "simple";
          Restart = "on-failure";
          RestartSec = "5s";
          ExecStart = pkgs.writeShellScript "kanshi-power-switcher" ''
            set -u

            kanshictl=${lib.getExe' pkgs.kanshi "kanshictl"}
            hyprctl=${hyprlandPkg}/bin/hyprctl
            jq=${lib.getExe pkgs.jq}
            udevadm=${lib.getExe' pkgs.systemd "udevadm"}

            last=""

            apply() {
              if [ "$(cat /sys/class/power_supply/ACAD/online 2>/dev/null)" = "1" ]; then
                suffix=ac
              else
                suffix=battery
              fi

              if "$hyprctl" -j monitors 2>/dev/null \
                | "$jq" -e 'any(.name == "DP-1")' >/dev/null 2>&1; then
                desired="docked-dp-$suffix"
              else
                desired="undocked-$suffix"
              fi

              if [ "$desired" != "$last" ]; then
                "$kanshictl" switch "$desired" 2>/dev/null && last="$desired" || true
              fi
            }

            apply
            "$udevadm" monitor --kernel \
                --subsystem-match=power_supply \
                --subsystem-match=drm \
              | while read -r _; do
                sleep 0.3
                apply
              done
          '';
        };
      };
    };
}
