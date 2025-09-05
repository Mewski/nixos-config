{ ... }:

{
  imports = [
    # Hardware configuration
    ./hardware-configuration.nix

    # Bootloader
    ../../modules/nixos/bootloader/systemd-boot.nix

    # Hardware modules
    ../../modules/nixos/hardware/bluetooth.nix
    ../../modules/nixos/hardware/nvidia.nix
  ];
}
