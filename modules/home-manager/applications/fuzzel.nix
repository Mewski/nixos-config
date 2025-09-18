{ config, lib, ... }:

{
  # Wayland application launcher with fuzzy search
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        # Manual font size adjustment
        font = lib.mkForce "${config.stylix.fonts.sansSerif.name}:size=12";
      };

      border = {
        # Adjust selection border to be round
        "selection-radius" = 4;

        # Adjust border width to match Hyprland
        width = 2;
      };
    };
  };
}
