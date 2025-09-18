{ ... }:

{
  # GPU-accelerated terminal emulator
  programs.kitty = {
    enable = true;

    settings = {
      # Disable window close confirmation
      confirm_os_window_close = 0;

      # Visual cursor trail effect
      cursor_trail = 2;

      # Disable audio notifications
      enable_audio_bell = false;

      # Window padding width
      window_padding_width = "0 2";
    };
  };
}
