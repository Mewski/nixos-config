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

    # Use stable driver branch (recommended for most users)
    # Alternative: set to "beta" for latest features
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable OpenGL support
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
