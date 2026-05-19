{
  flake.nixosModules.nvidia =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      services.xserver.videoDrivers = [
        "modesetting"
        "nvidia"
      ];

      hardware = {
        graphics.extraPackages = with pkgs; [
          libva
          libva-vdpau-driver
          libvdpau
          nvidia-vaapi-driver
        ];

        nvidia = {
          open = lib.mkDefault false;
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
