{
  lib,
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    # Lanzaboote secure boot implementation
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # Boot loader configuration
  boot.loader = {
    # Replace systemd-boot with Lanzaboote for secure boot support
    systemd-boot.enable = lib.mkForce false;

    # Allow modification of EFI variables for secure boot management
    efi.canTouchEfiVariables = true;
  };

  # Lanzaboote secure boot configuration
  boot.lanzaboote = {
    enable = true;
    # Path to secure boot keys managed by sbctl
    pkiBundle = "/var/lib/sbctl";
  };

  # Secure boot key management utility
  environment.systemPackages = with pkgs; [
    sbctl
  ];
}
