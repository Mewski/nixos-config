{ pkgs, ... }:

{
  # Install virtualization management tools
  environment.systemPackages = with pkgs; [
    virt-manager
  ];

  # Configure libvirt virtualization daemon
  virtualisation.libvirtd = {
    enable = true;
    qemu.runAsRoot = false;
    allowedBridges = [ ];
  };
}
