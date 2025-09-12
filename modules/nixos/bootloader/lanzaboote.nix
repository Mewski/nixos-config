{
  lib,
  inputs,
  ...
}:

{
  imports = [
    # Lanzaboote secure boot module
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # Replace systemd-boot with Lanzaboote for secure boot
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    # Path to secure boot keys managed by sbctl
    pkiBundle = "/var/lib/sbctl";
  };

  # Allow modifying EFI variables for secure boot key management
  boot.loader.efi.canTouchEfiVariables = true;
}
