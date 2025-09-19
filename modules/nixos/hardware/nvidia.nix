{ config, pkgs, ... }:

{
  # NVIDIA proprietary driver configuration
  services.xserver.videoDrivers = [ "nvidia" ];

  # Hardware graphics acceleration support
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # 32-bit application compatibility

    # Hardware video acceleration packages
    extraPackages = with pkgs; [
      libva
      libvdpau
      nvidia-vaapi-driver
      vaapiVdpau
    ];
  };

  # NVIDIA driver configuration
  hardware.nvidia = {
    # Enable modesetting for Wayland compositor compatibility
    modesetting.enable = true;

    # Use proprietary driver for better stability
    open = false;

    # Enable NVIDIA settings GUI application
    nvidiaSettings = true;

    # Use latest stable driver package
    package = config.boot.kernelPackages.nvidiaPackages.latest;

    # Power management configuration
    powerManagement = {
      enable = true;
      finegrained = true;
    };
  };

  # Enable memory preservation for NVIDIA GPU
  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

  # CUDA support configuration
  nixpkgs.config.cudaSupport = true;
}
