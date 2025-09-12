{ ... }:

{
  # Enable real-time scheduling for audio applications
  security.rtkit.enable = true;

  # Modern audio server replacing PulseAudio
  services.pipewire = {
    enable = true;

    # ALSA compatibility layer
    alsa = {
      enable = true;
      support32Bit = true; # 32-bit compatibility
    };

    # PulseAudio compatibility layer
    pulse.enable = true;

    # JACK compatibility for professional audio
    jack.enable = true;
  };
}
