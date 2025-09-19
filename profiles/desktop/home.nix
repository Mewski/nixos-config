{
  settings,
  pkgs,
  ...
}:

{
  imports = [
    # Host-specific home environment overrides
    ../../hosts/${settings.system.host}/home-overrides.nix

    # Application configurations
    ../../modules/home-manager/applications/btop.nix
    ../../modules/home-manager/applications/git.nix
    ../../modules/home-manager/applications/gitkraken.nix
    ../../modules/home-manager/applications/kitty.nix
    ../../modules/home-manager/applications/nixcord.nix
    ../../modules/home-manager/applications/nixvim.nix
    ../../modules/home-manager/applications/rofi.nix
    ../../modules/home-manager/applications/waybar.nix
    ../../modules/home-manager/applications/zed.nix
    ../../modules/home-manager/applications/zen-browser.nix

    # Desktop environment configuration
    ../../modules/home-manager/desktop/hyprland.nix
    ../../modules/home-manager/desktop/hypridle.nix
    ../../modules/home-manager/desktop/hyprlock.nix

    # Shell configurations
    ../../modules/home-manager/shell

    # User-specific theming
    ../../modules/home-manager/theme/stylix.nix
  ];

  # Additional packages not configured through dedicated modules
  home.packages = with pkgs; [
    bitwarden-desktop
    brightnessctl
    fastfetch
    nil
    nixd
    nixfmt-rfc-style
    pavucontrol
    playerctl
  ];

  # Enable Home Manager self-management
  programs.home-manager.enable = true;

  # Home Manager release version for state compatibility
  home.stateVersion = "25.05";
}
