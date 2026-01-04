{
  flake.nixosModules.nvidia =
    { config, pkgs, ... }:
    {
      services.xserver.videoDrivers = [
        "nvidia"
        "modesetting"
      ];

      hardware = {
        graphics.extraPackages = with pkgs; [
          libva
          nvidia-vaapi-driver
          libvdpau
          libva-vdpau-driver
        ];

        nvidia = {
          open = false;
          package = config.boot.kernelPackages.nvidiaPackages.latest;
          powerManagement.enable = true;
          modesetting.enable = true;
        };
      };

      nixpkgs.config.cudaSupport = true;

      environment.sessionVariables = {
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        LIBVA_DRIVER_NAME = "nvidia";
        NVD_BACKEND = "direct";
      };
    };
}
