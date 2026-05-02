{
  flake.nixosModules.zephyrus =
    { config, pkgs, ... }:
    {
      boot = {
        kernelModules = [
          "vfio"
          "vfio_iommu_type1"
          "vfio_pci"
          "kvmfr"
        ];
        extraModulePackages = [ config.boot.kernelPackages.kvmfr ];
        extraModprobeConfig = ''
          options kvmfr static_size_mb=128
        '';
      };

      services.supergfxd.settings = {
        mode = "Hybrid";
        vfio_enable = true;
        vfio_save = false;
      };

      services.udev.extraRules = ''
        SUBSYSTEM=="kvmfr", OWNER="mewski", GROUP="kvm", MODE="0660"
      '';

      systemd.tmpfiles.rules = [
        "f /dev/shm/looking-glass 0660 mewski qemu-libvirtd -"
      ];

      users.users.mewski.extraGroups = [ "kvm" ];

      environment.systemPackages = [ pkgs.looking-glass-client ];
    };
}
