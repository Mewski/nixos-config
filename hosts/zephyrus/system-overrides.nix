{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Secure boot key management for Lanzaboote
    sbctl
  ];
}
