{
  settings,
  pkgs,
  ...
}:

{
  imports = [
    # Host-specific home overrides
    ../../hosts/${settings.system.host}/home-overrides.nix

    # Terminal applications
    ../../modules/home-manager/applications/btop/btop.nix
    ../../modules/home-manager/applications/git/git.nix
    ../../modules/home-manager/applications/neovim/neovim.nix
    ../../modules/home-manager/applications/terminals/kitty.nix

    # Shells
    ../../modules/home-manager/shells/bash.nix
    ../../modules/home-manager/shells/fish.nix

    # Window manager configuration
    ../../modules/home-manager/desktop/hyprland.nix

    # Web browser
    ../../modules/home-manager/applications/web-browsers/zen-browser.nix
  ];

  # Install user-specific packages
  home.packages = with pkgs; [
    # Terminal utilities
    brightnessctl
    playerctl

    # Password manager
    bitwarden-desktop

    # Development tools
    gitkraken
  ];

  # Enable Home Manager to manage itself
  programs.home-manager.enable = true;

  # Home Manager state version for defaults
  home.stateVersion = "25.05";
}
