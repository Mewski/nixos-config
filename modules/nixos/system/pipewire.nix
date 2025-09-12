{ ... }:

{
  # Allows audio applications to request real-time scheduling
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true; # 32-bit compatibility
    };
    pulse.enable = true;
    jack.enable = true;
  };
}
