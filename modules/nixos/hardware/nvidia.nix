{ ... }:

{
  # Configure NVIDIA graphics driver
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Enable modesetting for Wayland compatibility
    modesetting.enable = true;

    # Use proprietary NVIDIA driver (not open source)
    open = false;

    # Enable NVIDIA settings GUI
    nvidiaSettings = true;
  };
}
