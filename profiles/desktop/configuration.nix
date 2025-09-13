{
  settings,
  pkgs,
  inputs,
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

    # Desktop environment
    ../../modules/nixos/desktop/hyprland.nix

    # Theme configuration
    ../../modules/nixos/theme/stylix.nix
  ];

  # Home Manager configuration
  home-manager = {
    extraSpecialArgs = { inherit inputs settings; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${settings.user.username} = import ./home.nix;
  };

  # Available shells
  environment.shells = with pkgs; [
    bash
    fish
  ];

  # Default shell configuration
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  # NixOS release version for compatibility
  system.stateVersion = "25.05";
}
