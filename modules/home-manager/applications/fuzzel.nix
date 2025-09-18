{ ... }:

{
  # Wayland application launcher with fuzzy search
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        # Monospace font with size 15
        font = "monospace:size=15";
      };

      border = {
        # Border width configuration
        width = 3;
      };
    };
  };
}
