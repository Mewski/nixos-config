{ pkgs, ... }:

{
  # Host-specific system configuration for ASUS ROG Zephyrus G16 GU605MY

  # Install sbctl for secure boot key management
  environment.systemPackages = with pkgs; [
    sbctl
  ];
}
