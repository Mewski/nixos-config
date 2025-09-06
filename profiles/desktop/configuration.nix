{
  settings,
  pkgs,
  ...
}:

{
  imports = [
    # Host-specific configuration
    ../../hosts/${settings.system.host}

    # Core system modules
    ../../modules/nixos/system/kernel.nix
    ../../modules/nixos/system/locale.nix
    ../../modules/nixos/system/networking.nix
    ../../modules/nixos/system/nix.nix
    ../../modules/nixos/system/pipewire.nix
    ../../modules/nixos/system/time.nix
    ../../modules/nixos/system/users.nix

    # Window manager
    ../../modules/nixos/desktop/hyprland.nix
  ];

  # Shells
  environment.shells = with pkgs; [
    bash
    fish
  ];

  # Set default shell
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  # System state version for defaults
  system.stateVersion = "25.05";
}
