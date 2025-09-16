{ inputs, ... }:

{
  imports = [
    inputs.nix4nvchad.homeManagerModules.nvchad
  ];

  # Neovim with NVChad configuration
  programs.nvchad = {
    enable = true;

    backup = false;
  };
}
