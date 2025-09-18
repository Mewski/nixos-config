{ ... }:

{
  # Wayland application launcher with fuzzy search
  programs.fuzzel = {
    enable = true;

    settings = {
      border = {
        # Border width configuration
        width = 0;
      };
    };
  };
}
