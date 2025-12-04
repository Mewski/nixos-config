{ inputs, ... }:
{
  flake.homeModules.binary-ninja = {
    imports = [ inputs.binary-ninja.hmModules.binaryninja ];

    programs.binary-ninja = {
      enable = true;
      package = inputs.binary-ninja.packages.x86_64-linux.binary-ninja-personal.override {
        overrideSource = ../../secrets/assets/binaryninja_personal_linux.zip;
      };
    };
  };
}
