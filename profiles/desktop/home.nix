{
  settings,
  pkgs,
  ...
}:

{
  imports = [
    # Host-specific home configuration overrides
    ../../hosts/${settings.system.host}/home-overrides.nix

    # Application modules
    ../../modules/home-manager/applications/btop.nix
    ../../modules/home-manager/applications/fuzzel.nix
    ../../modules/home-manager/applications/git.nix
    ../../modules/home-manager/applications/kitty.nix
    ../../modules/home-manager/applications/nixcord.nix
    ../../modules/home-manager/applications/nixvim.nix
    ../../modules/home-manager/applications/zen-browser.nix

    # Shell configurations
    ../../modules/home-manager/shell/bash.nix
    ../../modules/home-manager/shell/fish.nix

    # Desktop environment
    ../../modules/home-manager/desktop/hyprland.nix

    # Theme configuration
    ../../modules/home-manager/theme/stylix.nix
  ];

  # Additional packages not configured through modules
  home.packages = with pkgs; [
    brightnessctl
    playerctl
    bitwarden-desktop
    gitkraken
    fastfetch
    pavucontrol
  ];

  # Enable Home Manager self-management
  programs.home-manager.enable = true;

  # Home Manager release version for compatibility
  home.stateVersion = "25.05";
}
