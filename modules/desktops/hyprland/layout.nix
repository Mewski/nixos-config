{
  flake.homeModules.hyprland = {
    wayland.windowManager.hyprland.settings = {
      general.layout = "dwindle";

      xwayland.force_zero_scaling = true;

      dwindle = {
        preserve_split = true;
        pseudotile = true;
      };

      master.new_status = "master";

      windowrule = [
        "no_initial_focus on, match:class ^$, match:title ^$, match:xwayland true, match:float true, match:fullscreen false, match:pin false"
        "suppress_event maximize, match:class .*"
        "immediate on, match:xwayland 1"
      ];
    };
  };
}
