{ inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  # Neovim configuration framework with Nix integration
  programs.nixvim = {
    enable = true;

    # Use system-wide package collection for consistency
    nixpkgs.useGlobalPackages = false;
  };
}
