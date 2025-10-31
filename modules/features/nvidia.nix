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
          libvdpau
          nvidia-vaapi-driver
          vaapiVdpau
        ];

        nvidia = {
          open = false;
          package = config.boot.kernelPackages.nvidiaPackages.latest;
          powerManagement = {
            enable = true;
            finegrained = true;
          };
        };
      };

      nixpkgs.config.cudaSupport = true;
    };
}
