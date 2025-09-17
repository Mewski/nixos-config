{ ... }:

{
  # Enable real-time scheduling for audio applications
  security.rtkit.enable = true;

  # PipeWire audio server replacing PulseAudio
  services.pipewire = {
    enable = true;

    # ALSA compatibility layer
    alsa = {
      enable = true;
      support32Bit = true; # 32-bit application compatibility
    };

    # JACK compatibility layer for professional audio
    jack.enable = true;

    # PulseAudio compatibility layer
    pulse.enable = true;

    # WirePlumber session manager for PipeWire
    wireplumber.enable = true;
  };
}
