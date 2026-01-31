{
  flake.homeModules.hyprland = {
    wayland.windowManager.hyprland.settings = {
      input = {
        kb_layout = "us";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        kb_variant = "";

        accel_profile = "flat";
        follow_mouse = 1;
        mouse_refocus = true;
        sensitivity = 0;
      };

      gesture = [ "3, horizontal, workspace" ];
    };
  };
}
