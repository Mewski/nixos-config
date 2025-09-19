{
  settings,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Host-specific hardware and system configuration
    ../../hosts/${settings.system.host}

    # Core system modules
    ../../modules/nixos/system/kernel.nix
    ../../modules/nixos/system/locale.nix
    ../../modules/nixos/system/networking.nix
    ../../modules/nixos/system/nix.nix
    ../../modules/nixos/system/pipewire.nix
    ../../modules/nixos/system/time.nix
    ../../modules/nixos/system/users.nix

    # Desktop environment configuration
    ../../modules/nixos/desktop/hyprland.nix

    # System-wide theming
    ../../modules/nixos/theme/stylix.nix
    ../../themes/${settings.user.theme}
  ];

  # Home Manager configuration
  home-manager = {
    extraSpecialArgs = { inherit inputs settings; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${settings.user.username} = import ./home.nix;
  };

  # Available system shells
  environment.shells = with pkgs; [
    bash
    fish
  ];

  # Default user shell configuration
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  # Enable ROCm support
  nixpkgs.config.rocmSupport = true;

  # NixOS release version for state compatibility
  system.stateVersion = "25.05";
}
