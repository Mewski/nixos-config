{ pkgs, ... }:

{
  # Enable Stylix for declarative theming
  stylix.enable = true;

  # Disable unwanted Stylix modules
  stylix.targets.console.enable = false;
  stylix.targets.grub.enable = false;
  stylix.targets.fish.enable = false;

  # Fonts
  stylix.fonts = {
    serif = {
      package = pkgs.source-serif;
      name = "Source Serif Pro";
    };
    sansSerif = {
      package = pkgs.inter;
      name = "Inter";
    };
    monospace = {
      package = pkgs.nerd-fonts.fira-code;
      name = "FiraCode Nerd Font Mono";
    };
    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };
}
