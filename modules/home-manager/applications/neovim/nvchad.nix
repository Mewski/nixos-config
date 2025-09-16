{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nix4nvchad.homeManagerModule.nvchad
  ];

  # Neovim with NVChad configuration
  programs.nvchad = {
    enable = true;

    backup = false;

    extraPlugins = with pkgs.vimPlugins; [ ];
  };
}
