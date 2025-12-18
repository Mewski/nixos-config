{ inputs, ... }:
{
  flake.homeModules.binary-ninja =
    { pkgs, ... }:
    {
      imports = [ inputs.binary-ninja.hmModules.binaryninja ];

      programs.binary-ninja = {
        enable = true;
        package =
          inputs.binary-ninja.packages.${pkgs.stdenv.hostPlatform.system}.binary-ninja-personal-wayland.override
            {
              overrideSource = "${inputs.mewski-assets}/installers/binaryninja_personal_linux.zip";
            };
      };

      home.file.".binaryninja/settings.json".text = builtins.toJSON {
        "ui.theme.name" = "Base16";
        "network.enableUpdates" = false;
        "network.enableReleaseNotes" = false;
      };
    };
}
