{
  flake.homeModules.hyprland =
    { lib, pkgs, ... }:
    {
      wayland.windowManager.hyprland.settings = {
        general.layout = "dwindle";

        xwayland.force_zero_scaling = true;

        dwindle = {
          preserve_split = true;
          pseudotile = true;
        };

        master.new_status = "master";

        workspace = [
          "special:scratchterm, on-created-empty:${lib.getExe pkgs.kitty} --class scratchterm"
          "special:scratchmusic, on-created-empty:${lib.getExe pkgs.spotify}"
        ];

        windowrule = [
          "no_initial_focus on, match:class ^$, match:title ^$, match:xwayland true, match:float true, match:fullscreen false, match:pin false"
          "suppress_event maximize, match:class .*"
          "immediate on, match:xwayland 1"
          "float, match:title (Open|Save|File|Folder|Browse|Choose|Select|Export|Import|Upload|Download)"
          "size 900 600, match:title (Open|Save|File|Folder|Browse|Choose|Select|Export|Import|Upload|Download)"
          "center, match:title (Open|Save|File|Folder|Browse|Choose|Select|Export|Import|Upload|Download)"
        ];
      };
    };
}
