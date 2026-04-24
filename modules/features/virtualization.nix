{
  flake.nixosModules.virtualization =
    { pkgs, ... }:
    {
      virtualisation.libvirtd = {
        enable = true;
        dbus.enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true;
          swtpm.enable = true;
        };
      };

      users.users.libvirtdbus.extraGroups = [ "libvirtd" ];

      programs.virt-manager.enable = true;

      networking.firewall.trustedInterfaces = [ "virbr0" ];

      environment.systemPackages = with pkgs; [
        spice
        spice-gtk
        spice-protocol
        libguestfs-with-appliance
        guestfs-tools
        virt-viewer
        virtio-win
      ];
    };
}
