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

      environment.systemPackages = [
        pkgs.spice
        pkgs.spice-gtk
        pkgs.spice-protocol

        pkgs.virt-viewer
      ];
    };
}
