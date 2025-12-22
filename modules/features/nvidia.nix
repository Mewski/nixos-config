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
        };
      };

      nixpkgs.config.cudaSupport = true;
    };
}
