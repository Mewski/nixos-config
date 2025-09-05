{ inputs, settings, ... }:

{
  imports = [
    ../../modules/home-manager/apps/terminal/kitty.nix
    ../../modules/home-manager/apps/neovim/neovim.nix
    ../../modules/home-manager/window-manager/hyprland.nix
  ];

  home.username = settings.user.username;
  home.homeDirectory = "/home/${settings.user.username}";

  programs.home-manager.enable = true;

  # Home Manager state version for defaults
  home.stateVersion = "25.05";
}
