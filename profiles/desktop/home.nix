{
  settings,
  pkgs,
  ...
}:

{
  imports = [
    ../../hosts/${settings.system.host}/home-overrides.nix
    ../../modules/home-manager/applications/btop/btop.nix
    ../../modules/home-manager/applications/git/git.nix
    ../../modules/home-manager/applications/neovim/neovim.nix
    ../../modules/home-manager/applications/terminal/kitty.nix
    ../../modules/home-manager/shell/bash.nix
    ../../modules/home-manager/shell/fish.nix
    ../../modules/home-manager/desktop/hyprland.nix
    ../../modules/home-manager/applications/web-browser/zen-browser.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    playerctl
    bitwarden-desktop
    gitkraken
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "25.05";
}
