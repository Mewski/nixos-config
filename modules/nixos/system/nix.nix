{ ... }:

{
  # Enable experimental Nix features required for flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow installation of unfree packages (e.g., NVIDIA drivers)
  nixpkgs.config.allowUnfree = true;
}
