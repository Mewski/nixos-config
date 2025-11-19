{
  flake.homeModules.kitty =
    {
      scheme,
      fonts,
      opacity,
      ...
    }:
    {
      programs.kitty = {
        enable = true;

        shellIntegration.enableFishIntegration = true;

        enableGitIntegration = true;

        settings = {
          cursor_trail = 1;
          confirm_os_window_close = 0;
        };
      };
    };
}
