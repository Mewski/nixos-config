{
  flake.homeModules.binary-ninja =
    { pkgs, ... }:
    let
      binary-ninja-mcp-plugin = pkgs.fetchFromGitHub {
        owner = "fosdickio";
        repo = "binary_ninja_mcp";
        rev = "v1.1.0";
        hash = "sha256-uDAR/M1HrdduKztjp+dHbL9cx+bMzasdTQ0yQr1t/+w=";
      };
    in
    {
      home = {
        packages = [ pkgs.binary-ninja-personal-wayland ];

        file.".binaryninja/settings.json".text = builtins.toJSON {
          "ui.theme.name" = "Ninja Dark";
          "network.enableUpdates" = false;
          "network.enableReleaseNotes" = false;
        };

        file.".binaryninja/plugins/binary_ninja_mcp".source = binary-ninja-mcp-plugin;

        sessionVariables.PYTHONPATH = "${pkgs.binary-ninja-personal-wayland}/opt/binaryninja/python";
      };
    };
}
