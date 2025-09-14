{ pkgs, inputs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Enable dconf for GNOME/GTK applications
  programs.dconf.enable = true;

  # D-Bus service for desktop applications
  services.dbus = {
    enable = true;
    packages = with pkgs; [ dconf ];
  };

  # X server configuration (needed for XWayland)
  services.xserver = {
    enable = true;
    displayManager = {
      startx.enable = true;
    };
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # XDG Desktop Portal for Wayland applications
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
    ];
  };

  # GNOME Keyring for password management
  security.pam.services.login.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  # Environment variables for Wayland compatibility
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
