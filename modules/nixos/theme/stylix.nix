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
}
