{
  flake.homeModules.hyprland = {
    wayland.windowManager.hyprland.settings = {
      xwayland = {
        force_zero_scaling = true;
      };

      dwindle = {
        preserve_split = true;
        pseudotile = true;
      };

      general.layout = "dwindle";

      master.new_status = "master";

      windowrule = [
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "suppressevent maximize, class:.*"
      ];
    };
  };
}
