{ pkgs, ... }:

{
  # Install sbctl for secure boot key management
  environment.systemPackages = with pkgs; [
    sbctl
  ];
}
