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
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "suppressevent maximize, class:.*"
      ];
    };
  };
}
