{ inputs, ... }:
{
  flake.homeModules.binary-ninja =
    { pkgs, ... }:
    {
      imports = [ inputs.binary-ninja.hmModules.binaryninja ];

      programs.binary-ninja = {
        enable = true;
        package =
          inputs.binary-ninja.packages.${pkgs.stdenv.hostPlatform.system}.binary-ninja-personal-wayland;
      };

      home.file.".binaryninja/settings.json".text = builtins.toJSON {
        "ui.theme.name" = "Ninja Dark";
        "network.enableUpdates" = false;
        "network.enableReleaseNotes" = false;
      };
    };
}
