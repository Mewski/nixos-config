{
  flake.homeModules.hyprland = {
    wayland.windowManager.hyprland.settings = {
      dwindle = {
        preserve_split = true;
        pseudotile = true;
      };

      general.layout = "dwindle";

      master.new_status = "master";

      windowrule = [
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        "suppressevent maximize, class:.*"

        "float, class:^(org.pulseaudio.pavucontrol)$"
        "size 400 500, class:^(org.pulseaudio.pavucontrol)$"
        "move 100%-410 50, class:^(org.pulseaudio.pavucontrol)$"
        "animation slide top, class:^(org.pulseaudio.pavucontrol)$"
        "stayfocused, class:^(org.pulseaudio.pavucontrol)$"

        "float, class:^(.blueman-manager-wrapped)$"
        "size 530 500, class:^(.blueman-manager-wrapped)$"
        "move 100%-540 50, class:^(.blueman-manager-wrapped)$"
        "animation slide top, class:^(.blueman-manager-wrapped)$"
        "stayfocused, class:^(.blueman-manager-wrapped)$"

        "float, class:^(nm-connection-editor)$"
        "size 450 550, class:^(nm-connection-editor)$"
        "move 100%-460 50, class:^(nm-connection-editor)$"
        "animation slide top, class:^(nm-connection-editor)$"
        "stayfocused, class:^(nm-connection-editor)$"
      ];
    };
  };
}
