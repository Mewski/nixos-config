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

  flake.homeModules.hyprland = {
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        env = [
          "ELECTRON_OZONE_PLATFORM_HINT,auto"
        ];
      };
    };
  };
}
