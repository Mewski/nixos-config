{ inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.asus-zephyrus-gu605my
    ./system-overrides.nix
    ./hardware-configuration.nix
    ../../modules/nixos/bootloader/lanzaboote.nix
    ../../modules/nixos/hardware/bluetooth.nix
    ../../modules/nixos/hardware/nvidia.nix
  ];
}
