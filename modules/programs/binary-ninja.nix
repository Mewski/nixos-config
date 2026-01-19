{ inputs, ... }:
{
  flake.homeModules.binary-ninja =
    { pkgs, ... }:
    {
      imports = [ inputs.binary-ninja.hmModules.binaryninja ];

      programs.binary-ninja = {
        enable = true;
        package = pkgs.binary-ninja-personal-wayland;
      };

      home = {
        file.".binaryninja/settings.json".text = builtins.toJSON {
          "ui.theme.name" = "Ninja Dark";
          "network.enableUpdates" = false;
          "network.enableReleaseNotes" = false;
        };

        sessionVariables.PYTHONPATH = "${pkgs.binary-ninja-personal-wayland}/opt/binaryninja/python";
      };
    };
}
