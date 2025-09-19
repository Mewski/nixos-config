{ inputs, pkgs, ... }:

{
  imports = [
    inputs.binaryninja.nixosModules.binaryninja
  ];

  programs.binary-ninja.enable = {
    enable = true;

    package = pkgs.binary-ninja-personal-wayland.override {
      overrideSource = ./binaryninja_personal_linux.zip;
    };
  };
}
