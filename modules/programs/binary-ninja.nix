{
  flake.homeModules.binary-ninja =
    { pkgs, ... }:
    {
      home = {
        packages = [ pkgs.binary-ninja-personal-wayland ];

        file.".binaryninja/settings.json".text = builtins.toJSON {
          "ui.theme.name" = "Ninja Dark";
          "network.enableUpdates" = false;
          "network.enableReleaseNotes" = false;
        };

        sessionVariables.PYTHONPATH = "${pkgs.binary-ninja-personal-wayland}/opt/binaryninja/python";
      };
    };
}
