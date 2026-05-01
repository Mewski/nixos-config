{
  flake.nixosModules.zephyrus =
    { lib, pkgs, ... }:
    {
      hardware = {
        graphics = {
          extraPackages = [ pkgs.intel-media-driver ];
          extraPackages32 = [ pkgs.pkgsi686Linux.intel-media-driver ];
        };

        nvidia = {
          powerManagement.finegrained = true;

          prime.offload = {
            enable = true;
            enableOffloadCmd = true;
          };
        };
      };

      services.udev.extraRules = ''
        SUBSYSTEM=="drm", KERNEL=="card[0-9]*", ENV{ID_PATH_TAG}=="pci-0000_00_02_0", SYMLINK+="dri/intel-igpu"
      '';

      environment.sessionVariables = {
        AQ_DRM_DEVICES = "/dev/dri/intel-igpu";

        __GLX_VENDOR_LIBRARY_NAME = lib.mkForce "mesa";
        LIBVA_DRIVER_NAME = lib.mkForce "iHD";
      };
    };
}
