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
        "suppress_event maximize, match:class .*"
        "immediate on, match:xwayland 1"
      ];
    };
  };
}
