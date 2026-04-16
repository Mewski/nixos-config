{
  flake.homeModules.niri = {
    programs.swaylock = {
      enable = true;
      settings = {
        daemonize = true;
        show-failed-attempts = false;
        ignore-empty-password = true;
        indicator-radius = 100;
        indicator-thickness = 10;
      };
    };
  };
}
