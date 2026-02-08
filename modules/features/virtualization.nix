{
  flake.nixosModules.virtualization =
    { pkgs, ... }:
    {
      virtualisation.libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true;
          swtpm.enable = true;
        };
      };

      programs.virt-manager.enable = true;

      environment.systemPackages = with pkgs; [
        spice
        spice-gtk
        spice-protocol
        libguestfs-with-appliance
        virt-viewer
      ];
    };
}
