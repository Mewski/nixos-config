{
  flake.nixosModules.crosshair =
    {
      config,
      lib,
      modulesPath,
      ...
    }:
    {
      imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

      boot = {
        extraModulePackages = [ ];
        kernelModules = [ "kvm-amd" ];
        kernelParams = [
          "amd_iommu=on"
          "vfio-pci.ids=10de:1e07,10de:10f7,10de:1ad6,10de:1ad7"
        ];
        initrd = {
          availableKernelModules = [
            "xhci_pci"
            "ahci"
            "thunderbolt"
            "nvme"
            "usbhid"
            "usb_storage"
            "sd_mod"
          ];
          kernelModules = [
            "vfio_pci"
            "vfio"
            "vfio_iommu_type1"
          ];
        };
      };

      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      networking.useDHCP = lib.mkDefault true;
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    };
}
