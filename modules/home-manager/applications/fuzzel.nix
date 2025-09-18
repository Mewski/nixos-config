{ config, lib, ... }:

{
  # Wayland application launcher with fuzzy search
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        # Manual font size adjustment
        font = lib.mkForce "${config.stylix.fonts.sansSerif.name}:size=12";

        # Allow bold text for selected item
        "use-bold" = lib.mkForce true;
      };
    };
  };
}
