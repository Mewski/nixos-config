{ inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  # Neovim configuration framework with Nix integration
  programs.nixvim.enable = true;
}
