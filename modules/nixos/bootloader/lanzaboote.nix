{
  lib,
  inputs,
  ...
}:

{
  imports = [
    # Lanzaboote bootloader
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # Replace systemd-boot with Lanzaboote for secure boot
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  # Enable bootloader to modify EFI variables
  boot.loader.efi.canTouchEfiVariables = true;
}
