{ inputs, self, ... }:
{
  flake.nixosModules.hyprland =
    { config, pkgs, ... }:
    {
      programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage =
          inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };

      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        XCURSOR_SIZE = toString config.theme.cursor.size;
      };

      environment.systemPackages = with pkgs; [
        libsForQt5.qtwayland
        kdePackages.qtwayland
      ];
    };

  flake.homeModules.hyprland =
    { pkgs, lib, ... }:
    {
      wayland.windowManager.hyprland = {
        enable = true;

        settings = {
          exec-once = [
            "${lib.getExe pkgs.waybar}"
            "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --type text --watch ${lib.getExe pkgs.cliphist} store"
            "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --type image --watch ${lib.getExe pkgs.cliphist} store"
          ];

          env = [
            "ELECTRON_OZONE_PLATFORM_HINT,auto"
          ];

          ecosystem = {
            no_update_news = true;
            no_donation_nag = true;
          };

          cursor = {
            inactive_timeout = 3;
            no_hardware_cursors = 1;
          };

          misc = {
            key_press_enables_dpms = true;
            middle_click_paste = false;
            mouse_move_enables_dpms = true;
            vfr = true;
          };
        };
      };

      services.hyprpolkitagent.enable = true;

      services.hyprpaper = {
        enable = true;

        settings = {
          preload = [ "${self}/assets/wallpapers/Kath.png" ];
          wallpaper = [ ", ${self}/assets/wallpapers/Kath.png" ];
        };
      };

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
              timeout = 195;
              on-timeout = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms off";
              on-resume = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms on";
            }
            {
              timeout = 300;
              on-timeout = "systemctl suspend";
            }
          ];
        };
      };

      xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        configPackages = [ pkgs.hyprland ];
      };
    };
}
