{ ... }:

{
  # Enable real-time kit for audio
  security.rtkit.enable = true;

  # Configure PipeWire audio system
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };
}
