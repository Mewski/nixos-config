{ inputs, pkgs, ... }:

{
  # Enable Stylix for declarative theming
  stylix.enable = true;

  # Disable unwanted Stylix modules
  stylix.targets.console.enable = false;
  stylix.targets.grub.enable = false;

  # Fonts
  stylix.fonts = {
    sansSerif = {
      name = "SFProDisplay Nerd Font";
      package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
    };
    serif = {
      name = "New York";
      package = inputs.apple-fonts.packages.${pkgs.system}.ny;
    };
    monospace = {
      name = "SF Mono Nerd Font";
      package = inputs.apple-fonts.packages.${pkgs.system}.sf-mono-nerd;
    };
    emoji = {
      name = "Noto Color Emoji";
      package = pkgs.noto-fonts-emoji;
    };
  };
}
