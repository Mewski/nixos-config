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

      environment.sessionVariables = {
        __GLX_VENDOR_LIBRARY_NAME = lib.mkForce "mesa";
        LIBVA_DRIVER_NAME = lib.mkForce "iHD";
      };
    };
}
