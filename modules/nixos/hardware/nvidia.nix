{ config, ... }:

{
  # Configure NVIDIA graphics driver
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Enable modesetting for Wayland compatibility
    modesetting.enable = true;

    # Use proprietary NVIDIA driver (not open source)
    # Set to true for newer GPUs to use open-source kernel modules
    open = false;

    # Enable NVIDIA settings GUI for configuration
    nvidiaSettings = true;

    # Use stable driver branch
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable general graphics support
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
}
