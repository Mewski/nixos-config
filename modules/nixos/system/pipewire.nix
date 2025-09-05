{ ... }:

{
  # Enable real-time kit for audio
  security.rtkit.enable = true;

  # Configure PipeWire audio system
  services.pipewire = {
    enable = true;
    # ALSA compatibility layer for legacy applications
    alsa = {
      enable = true;
      support32Bit = true; # Enable 32-bit application support
    };
    # PulseAudio compatibility layer
    pulse.enable = true;
    # JACK compatibility for professional audio applications
    jack.enable = true;
  };
}
