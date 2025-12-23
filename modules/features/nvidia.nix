{
  flake.nixosModules.nvidia =
    { config, pkgs, ... }:
    {
      services.xserver.videoDrivers = [
        "nvidia"
        "modesetting"
      ];

      hardware = {
        graphics.extraPackages = [
          pkgs.libva
          pkgs.nvidia-vaapi-driver

          pkgs.libvdpau
          pkgs.libva-vdpau-driver
        ];

        nvidia = {
          open = false;
          package = config.boot.kernelPackages.nvidiaPackages.latest;
          powerManagement.enable = true;
        };
      };

      nixpkgs.config.cudaSupport = true;
    };
}
