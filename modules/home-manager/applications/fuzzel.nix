{ ... }:

{
  # Wayland application launcher with fuzzy search
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        # Enable DPI awareness for high-resolution displays
        "dpi-aware" = "yes";
      };

      border = {
        # Remove border so Hyprland can manage it
        width = 2;
      };
    };
  };
}
