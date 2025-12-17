{ inputs, ... }:
{
  flake.nixosModules.binary-ninja =
    { pkgs, ... }:
    {
      imports = [ inputs.binary-ninja.nixosModules.binaryninja ];

      programs.binary-ninja = {
        enable = true;
        package = inputs.binary-ninja.packages.${pkgs.system}.binary-ninja-personal-wayland.override {
          overrideSource = "${inputs.mewski-assets}/installers/binaryninja_personal_linux.zip";
        };
      };
    };
}
