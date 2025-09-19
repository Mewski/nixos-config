{ config, pkgs, ... }:

{
  # Distributed version control system with enhanced configuration
  programs.git = {
    enable = true;

    # Git Large File Storage for handling large binary files
    git-lfs = {
      enable = true;
      package = pkgs.git-lfs;
    };

    # User identity configuration
    userEmail = "mewski@mewski.dev";
    userName = "Mewski";

    # Core Git configuration
    extraConfig = {
      # Commit signing configuration
      commit = {
        gpgsign = true;
      };

      # Tag signing configuration
      tag = {
        forcesignannotated = true;
      };

      # GPG configuration for SSH signing
      gpg = {
        format = "ssh";
      };

      # User signing key configuration
      user = {
        signingkey = "${config.home.homeDirectory}/.ssh/id_25519";
      };

      # Core editor configuration
      core = {
        editor = "nvim";
      };

      # Default branch naming
      init = {
        defaultBranch = "master";
      };
    };
  };
}
