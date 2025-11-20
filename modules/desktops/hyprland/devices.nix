{
  flake.homeModules.hyprland = {
    wayland.windowManager.hyprland.settings = {
      input = {
        accel_profile = "flat";
        follow_mouse = 1;
        sensitivity = 0.25;

        kb_layout = "us";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        kb_variant = "";

        touchpad = {
          clickfinger_behavior = true;
          disable_while_typing = true;
          natural_scroll = true;
          scroll_factor = 0.5;
        };
      };

      gesture = [
        "3, horizontal, workspace"
      ];
    };
  };
}
