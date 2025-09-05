{ pkgs, ... }:

{
  # Install Neovim text editor
  home.packages = with pkgs; [
    neovim
  ];

  # Enable Neovim program configuration
  programs.neovim.enable = true;
}
