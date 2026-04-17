{ inputs, ... }:
{
  flake.homeModules.hyprland =
    { pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      splitMonitorWorkspaces =
        inputs.split-monitor-workspaces.packages.${system}.split-monitor-workspaces.overrideAttrs
          (old: {
            postPatch = (old.postPatch or "") + ''
              sed -i 's/m_disabled/disabled/g' src/main.cpp
            '';
          });
    in
    {
      wayland.windowManager.hyprland = {
        plugins = [ splitMonitorWorkspaces ];

        settings."plugin:split-monitor-workspaces" = {
          count = 10;
          enable_persistent_workspaces = 0;
        };
      };
    };
}
