{
  flake.nixosModules.astraeus =
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
        kernelModules = [ "kvm-intel" ];

        initrd = {
          availableKernelModules = [
            "ahci"
            "ehci_pci"
            "mpt3sas"
            "sd_mod"
            "uhci_hcd"
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
