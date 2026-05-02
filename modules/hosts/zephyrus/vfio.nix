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
          "/dev/ptmx", "/dev/userfaultfd"
        ]
      '';
    };
}
