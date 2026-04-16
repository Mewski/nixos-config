{
  flake.homeModules.niri = {
    programs.niri.settings.input = {
      keyboard.xkb = {
        layout = "us";
      };

      touchpad = {
        enable = true;
        tap = true;
        click-method = "clickfinger";
        dwt = true;
        natural-scroll = true;
        accel-profile = "flat";
      };

      mouse = {
        enable = true;
        accel-profile = "flat";
      };

      focus-follows-mouse.enable = true;
    };
  };
}
