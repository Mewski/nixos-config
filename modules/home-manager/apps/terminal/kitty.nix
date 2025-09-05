{ pkgs, ... }:

{
  # Install Kitty terminal emulator
  home.packages = with pkgs; [
    kitty
  ];

  # Enable Kitty program configuration
  programs.kitty.enable = true;
}
