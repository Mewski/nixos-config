{ ... }:

{
  # Modern shell with autosuggestions and syntax highlighting
  programs.fish = {
    enable = true;

    # Automatically start Hyprland
    loginShellInit = ''
      if uwsm check may-start
          exec uwsm start hyprland-uwsm.desktop
      end
    '';
  };
}
