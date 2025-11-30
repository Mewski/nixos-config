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
    { pkgs, lib, ... }:
    {
      wayland.windowManager.hyprland = {
        enable = true;

        settings = {
          exec-once = [
            "${lib.getExe pkgs.waybar}"
            "${lib.getExe pkgs.hypridle}"
            "systemctl --user start hyprpolkitagent"
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
        };
      };

      home.packages = with pkgs; [
        hyprland-qt-support
        hyprland-qtutils
        hyprpolkitagent
        qt5.qtwayland
        qt6.qtwayland
      ];
    };
}
