{
  lib,
  inputs,
  ...
}:

{
  imports = [
    # Lanzaboote secure boot implementation
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # Replace systemd-boot with Lanzaboote for secure boot support
  boot.loader.systemd-boot.enable = lib.mkForce false;

  # Lanzaboote secure boot configuration
  boot.lanzaboote = {
    enable = true;
    # Path to secure boot keys managed by sbctl
    pkiBundle = "/var/lib/sbctl";
  };

  # Allow modification of EFI variables for secure boot management
  boot.loader.efi.canTouchEfiVariables = true;
}
