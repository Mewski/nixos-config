{ ... }:

{
  # Enable experimental Nix features
  nix.settings.experimental-features = [
    "nix-command" # New nix CLI commands
    "flakes" # Flake-based package management
  ];

  # Enable unfree packages
  nixpkgs.config.allowUnfree = true;
}
