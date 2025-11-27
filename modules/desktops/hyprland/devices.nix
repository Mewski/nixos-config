{
  flake.homeModules.hyprland = {
    wayland.windowManager.hyprland.settings = {
      input = {
        accel_profile = "flat";
        follow_mouse = 1;
        sensitivity = 0;

        kb_layout = "us";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        kb_variant = "";
      };

      gesture = [
        "3, horizontal, workspace"
      ];
    };
  };
}
