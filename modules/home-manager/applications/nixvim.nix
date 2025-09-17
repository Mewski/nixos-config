{ inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  # Vim-based text editor
  programs.nixvim.enable = true;
}
