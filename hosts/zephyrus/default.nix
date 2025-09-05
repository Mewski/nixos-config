{ inputs, ... }:

{
  imports = [
    # Hardware configurations from nixos-hardware
    inputs.nixos-hardware.nixosModules.asus-zephyrus-gu605my

    # Generated hardware configuration
    ./hardware-configuration.nix

    # Bootloader configuration
    ../../modules/nixos/bootloader/systemd-boot.nix

    # Hardware-specific modules
    ../../modules/nixos/hardware/bluetooth.nix
    ../../modules/nixos/hardware/nvidia.nix
  ];
}
