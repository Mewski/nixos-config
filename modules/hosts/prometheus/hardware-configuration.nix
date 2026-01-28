{
  flake.nixosModules.prometheus =
    {
      lib,
      modulesPath,
      ...
    }:
    {
      imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

      boot = {
        extraModulePackages = [ ];
        kernelModules = [ ];
        initrd = {
          availableKernelModules = [
            "ahci"
            "xhci_pci"
            "sr_mod"
          ];
          kernelModules = [ ];
        };
      };

      networking.useDHCP = lib.mkDefault true;
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    };
}
