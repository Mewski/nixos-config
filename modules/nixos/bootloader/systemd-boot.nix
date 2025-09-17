{ ... }:

{
  # Boot loader configuration
  boot.loader = {
    # Standard systemd-boot bootloader configuration
    systemd-boot.enable = true;

    # Allow modification of EFI variables
    efi.canTouchEfiVariables = true;
  };
}
