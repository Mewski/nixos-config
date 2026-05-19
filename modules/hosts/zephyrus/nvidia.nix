{
  flake.nixosModules.zephyrus =
    { pkgs, ... }:
    {
      hardware = {
        graphics = {
          extraPackages = [ pkgs.intel-media-driver ];
          extraPackages32 = [ pkgs.pkgsi686Linux.intel-media-driver ];
        };
      };

      services.udev.extraRules = ''
        SUBSYSTEM=="drm", KERNEL=="card[0-9]*", ENV{ID_PATH_TAG}=="pci-0000_00_02_0", SYMLINK+="dri/intel-igpu"
      '';
    };
}
