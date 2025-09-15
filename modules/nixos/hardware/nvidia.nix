{ config, pkgs, ... }:

{
  # Use NVIDIA proprietary driver
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Enable modesetting for Wayland compatibility
    modesetting.enable = true;

    # Use proprietary driver (more stable than open-source)
    open = false;

    # Enable nvidia-settings GUI
    nvidiaSettings = true;

    # Use stable driver package
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  # Enable hardware acceleration
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true; # 32-bit compatibility

  # Hardware video acceleration
  hardware.graphics.extraPackages = [
    pkgs.nvidia-vaapi-driver
  ];
}
