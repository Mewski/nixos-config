{
  flake.nixosModules.zephyrus =
    { ... }:
    {
      boot.kernelModules = [
        "vfio"
        "vfio_iommu_type1"
        "vfio_pci"
      ];

      boot.extraModprobeConfig = ''
        softdep nvidia pre: vfio-pci
        softdep nvidia_drm pre: vfio-pci
        softdep nvidia_modeset pre: vfio-pci
      '';

      services.udev.extraRules = ''
        ACTION=="bind", SUBSYSTEM=="pci", DRIVER=="vfio-pci", \
          KERNEL=="0000:01:00.0", ATTR{power/control}="on", ATTR{d3cold_allowed}="0"
        ACTION=="bind", SUBSYSTEM=="pci", DRIVER=="vfio-pci", \
          KERNEL=="0000:01:00.1", ATTR{power/control}="on"
        ACTION=="add", SUBSYSTEM=="pci", KERNEL=="0000:00:01.0", \
          ATTR{power/control}="on", ATTR{d3cold_allowed}="0"
      '';

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
