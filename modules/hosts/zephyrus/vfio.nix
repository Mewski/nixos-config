{
  flake.nixosModules.zephyrus =
    { ... }:
    {
      boot.kernelModules = [
        "vfio"
        "vfio_iommu_type1"
        "vfio_pci"
      ];

      services.supergfxd.settings = {
        mode = "Hybrid";
        vfio_enable = true;
        vfio_save = false;
      };

      virtualisation.libvirtd.qemu.verbatimConfig = ''
        namespaces = []
        cgroup_device_acl = [
          "/dev/null", "/dev/full", "/dev/zero",
          "/dev/random", "/dev/urandom",
          "/dev/ptmx", "/dev/userfaultfd",
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd",
          "/dev/input/by-path/pci-0000:00:14.0-usb-0:6:1.0-event-mouse",
          "/dev/input/by-path/pci-0000:00:15.3-platform-i2c_designware.1-event-mouse"
        ]
      '';
    };
}
