{ ... }:

{
  # Standard systemd-boot bootloader configuration
  boot.loader.systemd-boot.enable = true;

  # Allow modification of EFI variables
  boot.loader.efi.canTouchEfiVariables = true;
}
