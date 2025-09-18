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
    ../../modules/home-manager/applications/kitty.nix
    ../../modules/home-manager/applications/nixcord.nix
    ../../modules/home-manager/applications/nixvim.nix
    ../../modules/home-manager/applications/rofi.nix
    ../../modules/home-manager/applications/waybar.nix
    ../../modules/home-manager/applications/zen-browser.nix

    # Desktop environment configuration
    ../../modules/home-manager/desktop/hyprland.nix

    # Shell configurations
    ../../modules/home-manager/shell/bash.nix
    ../../modules/home-manager/shell/fish.nix

    # User-specific theming
    ../../modules/home-manager/theme/stylix.nix
  ];

  # Additional packages not configured through dedicated modules
  home.packages = with pkgs; [
    bitwarden-desktop
    brightnessctl
    fastfetch
    gitkraken
    pavucontrol
    playerctl
  ];

  # Enable Home Manager self-management
  programs.home-manager.enable = true;

  # Home Manager release version for state compatibility
  home.stateVersion = "25.05";
}
