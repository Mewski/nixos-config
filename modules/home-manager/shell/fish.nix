{ ... }:

{
  # Fish shell with autosuggestions and syntax highlighting
  programs.fish = {
    enable = true;

    # Automatically start Hyprland on tty1 only
    loginShellInit = ''
      if test (tty) = "/dev/tty1"
        Hyprland
      end
    '';
  };
}
