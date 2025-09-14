{ ... }:

{
  # Modern shell with autosuggestions and syntax highlighting
  programs.fish = {
    enable = true;

    # Automatically start Hyprland
    loginShellInit = ''
      Hyprland
    '';
  };
}
