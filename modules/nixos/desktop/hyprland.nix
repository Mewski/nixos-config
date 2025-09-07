{ pkgs, inputs, ... }:

{
  # Configure Hyprland window manager
  programs.hyprland = {
    enable = true;
    # Enable X11 compatibility layer for legacy applications
    xwayland.enable = true;
    # Use Hyprland package from flake input for latest features
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # Use matching portal package for proper desktop integration
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Enable dconf for GTK application settings
  programs.dconf.enable = true;

  # Configure D-Bus for inter-process communication
  services.dbus = {
    enable = true;
    packages = with pkgs; [ dconf ];
  };

  # Configure X server for compatibility and keyboard layout
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

  # Configure XDG desktop portals for file dialogs and desktop integration
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
    ];
  };

  # Enable GNOME Keyring for secure credential storage
  security.pam.services.login.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  # Enable Ozone Wayland support for Hyprland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
