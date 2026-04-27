{
  flake.homeModules.hyprland = {
    wayland.windowManager.hyprland.settings = {
      general.layout = "scrolling";

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
        "opacity 1.0 override 1.0 override, match:class kitty"
        "float on, match:class xdg-desktop-portal-gtk"
        "size 900 600, match:class xdg-desktop-portal-gtk"
        "center on, match:class xdg-desktop-portal-gtk"
        "float on, match:title (Open|Save|File|Folder|Browse|Choose|Select|Export|Import|Upload|Download)"
        "size 900 500, match:title (Open|Save|File|Folder|Browse|Choose|Select|Export|Import|Upload|Download)"
        "center on, match:title (Open|Save|File|Folder|Browse|Choose|Select|Export|Import|Upload|Download)"
      ];
    };
  };
}
