{ pkgs, ... }:

{
  # Enable Stylix for declarative system-wide theming
  stylix.enable = true;

  # Font configuration for system-wide use
  stylix.fonts = {
    # Emoji font for Unicode emoji support
    emoji = {
      name = "Noto Color Emoji";
      package = pkgs.noto-fonts-emoji;
    };

    # Monospace font for terminals and code editors
    monospace = {
      name = "FiraCode Nerd Font Mono";
      package = pkgs.nerd-fonts.fira-code;
    };

    # Sans-serif font for UI elements
    sansSerif = {
      name = "Inter";
      package = pkgs.inter;
    };

    # Serif font for document text
    serif = {
      name = "Source Serif Pro";
      package = pkgs.source-serif;
    };
  };

  # Disable unwanted Stylix targets
  stylix.targets = {
    # Disable console theming to preserve system defaults
    console.enable = false;

    # Disable Fish shell theming for custom configuration
    fish.enable = false;

    # Disable GRUB theming for bootloader consistency
    grub.enable = false;
  };
}
