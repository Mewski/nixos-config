{ inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  # Neovim configuration framework with Nix integration
  programs.nixvim = {
    enable = true;

    # Disable problematic language servers
    plugins.lsp = {
      enable = true;
      servers = {
        # Disable dockerfile language server
        dockerls.enable = false;
      };
    };
  };
}
