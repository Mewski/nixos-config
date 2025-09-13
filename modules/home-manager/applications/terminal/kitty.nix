{ ... }:

{
  # GPU-accelerated terminal emulator
  programs.kitty = {
    enable = true;

    settings = {
      cursor_trail = 5;
      enable_audio_bell = false;
      confirm_os_window_close = 0;
    }
  };
}
