{
  flake.homeModules.niri = {
    programs.niri.settings.input = {
      keyboard.xkb = {
        layout = "us";
        model = "";
        options = "";
        rules = "";
        variant = "";
      };

      mouse = {
        accel-profile = "flat";
        accel-speed = 0.0;
      };

      touchpad = {
        accel-profile = "flat";
        accel-speed = 0.0;
        click-method = "clickfinger";
        dwt = true;
        natural-scroll = true;
        scroll-factor = 0.35;
      };

      trackpoint = {
        accel-profile = "flat";
        accel-speed = 0.0;
      };

      focus-follows-mouse.enable = true;
      mod-key = "Super";
    };
  };
}
