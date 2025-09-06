{ pkgs, inputs, ... }:

{
  imports = [
    # Hardware configurations from nixos-hardware
    inputs.nixos-hardware.nixosModules.asus-zephyrus-gu605my

    # Generated hardware configuration
    ./hardware-configuration.nix

    # Bootloader configuration
    ../../modules/nixos/bootloader/lanzaboote.nix

    # Hardware-specific modules
    ../../modules/nixos/hardware/bluetooth.nix
    ../../modules/nixos/hardware/nvidia.nix
  ];

  # Install sbctl for secure boot key management
  environment.systemPackages = with pkgs; [
    sbctl
  ];
}
