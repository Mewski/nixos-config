{ inputs, ... }:
{
  flake.nixosModules.hyprland =
    { pkgs, ... }:
    {
      programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage =
          inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };

      programs.dconf.enable = true;

      environment.sessionVariables.NIXOS_OZONE_WL = "1";
    };

  flake.homeModules.hyprland =
    { lib, pkgs, ... }:
    {
      programs.hyprlock.enable = true;

      services.hypridle = {
        enable = true;

        settings = {
          general = {
            before_sleep_cmd = "${lib.getExe pkgs.hyprlock}";
            after_sleep_cmd = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms on";
            ignore_dbus_inhibit = false;
            lock_cmd = "${lib.getExe pkgs.hyprlock}";
          };

          listener = [
            {
              timeout = 190;
              on-timeout = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms off";
              on-resume = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms on";
            }
            {
              timeout = 195;
              on-timeout = "systemctl suspend";
            }
          ];
        };
      };

      wayland.windowManager.hyprland = {
        enable = true;

        settings = {
          exec-once = [
            "waybar"
            "hypridle"
          ];

          env = [
            "ELECTRON_OZONE_PLATFORM_HINT,auto"
          ];

          ecosystem = {
            no_update_news = true;
            no_donation_nag = true;
          };
        };
      };
    };
}
