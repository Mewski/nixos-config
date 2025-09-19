{ ... }:

{
  # Import shell-specific configurations
  imports = [
    ./bash.nix
    ./fish.nix
  ];

  # Set default editor to nvim
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
