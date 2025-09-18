{ pkgs, inputs, ... }:

{
  # Hyprland window manager system configuration
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
  };

  # Hyprland screen locking utility
  programs.hyprlock.enable = true;

  # Hyprland idle daemon for automatic actions
  services.hypridle.enable = true;

  # Enable dconf for GNOME/GTK application settings
  programs.dconf.enable = true;

  # D-Bus service for desktop applications
  services.dbus = {
    enable = true;
    packages = with pkgs; [ dconf ];
  };

  # GNOME Keyring for password and secret management
  security.pam.services.login.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  # X server configuration for XWayland compatibility
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

  # XDG Desktop Portal for Wayland application integration
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
    ];
  };

  # Environment variables for Wayland application compatibility
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
