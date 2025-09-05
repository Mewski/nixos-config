{ ... }:

{
  # Enable systemd-boot bootloader
  boot.loader.systemd-boot.enable = true;

  # Allow bootloader to modify EFI variables
  boot.loader.efi.canTouchEfiVariables = true;
}
