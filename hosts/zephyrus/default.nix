{ ... }:

{
  imports = [
    # Generated hardware configuration
    ./hardware-configuration.nix

    # Bootloader configuration
    ../../modules/nixos/bootloader/systemd-boot.nix

    # Hardware-specific modules
    ../../modules/nixos/hardware/bluetooth.nix
    ../../modules/nixos/hardware/nvidia.nix
  ];
}
