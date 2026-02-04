{ inputs, self, ... }:
{
  flake.nixosModules.hyprland =
    { pkgs, ... }:
    let
      hyprlandPkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      programs.hyprland = {
        enable = true;
        package = hyprlandPkgs.hyprland;
        portalPackage = hyprlandPkgs.xdg-desktop-portal-hyprland;
      };

      environment = {
        sessionVariables.NIXOS_OZONE_WL = "1";

        systemPackages = with pkgs; [
          libsForQt5.qtwayland
          kdePackages.qtwayland
        ];
      };
    };

  flake.homeModules.hyprland =
    { lib, pkgs, ... }:
    {
      imports = [
        self.homeModules.dunst
        self.homeModules.hypridle
        self.homeModules.hyprpaper
        self.homeModules.waybar
      ];

      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = true;

        settings = {
          exec-once = [
            "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --type text --watch ${lib.getExe pkgs.cliphist} store"
            "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --type image --watch ${lib.getExe pkgs.cliphist} store"
          ];

          env = [ "ELECTRON_OZONE_PLATFORM_HINT,auto" ];

          ecosystem = {
            no_update_news = true;
            no_donation_nag = true;
          };

          cursor = {
            no_hardware_cursors = false;
            use_cpu_buffer = true;
            sync_gsettings_theme = true;
            zoom_rigid = true;
            zoom_detached_camera = false;
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

      xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        configPackages = [ pkgs.hyprland ];
      };

      home.packages = with pkgs; [
        cliphist
        hyprpicker
        hyprshot
        satty
        tesseract
        wl-clipboard
      ];
    };
}
