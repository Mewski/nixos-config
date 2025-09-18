{ ... }:

{
  # Wayland application launcher with fuzzy search
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        # DPI awareness for high-resolution displays
        "dpi-aware" = "yes";
      };

      border = {
        # Border width configuration
        width = 0;
      };
    };
  };
}
