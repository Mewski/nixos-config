{
  flake.nixosModules.zephyrus =
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
        kernelModules = [
          "kvm-intel"
          "vhost_net"
          "vhost_vsock"
        ];
        extraModprobeConfig = ''
          options kvm_intel nested=Y emulate_invalid_guest_state=N
        '';
        initrd = {
          availableKernelModules = [
            "nvme"
            "rtsx_pci_sdmmc"
            "sd_mod"
            "thunderbolt"
            "usb_storage"
            "usbhid"
            "xhci_pci"
          ];
          kernelModules = [ ];
        };
      };

      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      networking.useDHCP = lib.mkDefault true;
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    };
}
