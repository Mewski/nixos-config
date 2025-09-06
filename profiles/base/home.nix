{ settings, ... }:

{
  imports = [
    # Terminal applications
    ../../modules/home-manager/apps/btop/btop.nix
    ../../modules/home-manager/apps/git/git.nix
    ../../modules/home-manager/apps/neovim/neovim.nix
    ../../modules/home-manager/apps/terminal/kitty.nix

    # Window manager configuration
    ../../modules/home-manager/window-manager/hyprland.nix
  ];

  # Configure home directory and username
  home.username = settings.user.username;
  home.homeDirectory = "/home/${settings.user.username}";

  # Enable Home Manager to manage itself
  programs.home-manager.enable = true;

  # Enable Bash shell configuration
  programs.bash.enable = true;

  # Enable Fish shell configuration
  programs.fish.enable = true;

  # Home Manager state version for defaults
  home.stateVersion = "25.05";
}
