{ self, ... }:
{
  flake.nixosModules.development = {
    imports = [
      self.nixosModules.docker
      self.nixosModules.virtualization
    ];

    home-manager.sharedModules = [ self.homeModules.development ];
  };

  flake.homeModules.development =
    { pkgs, ... }:
    {
      imports = [
        self.homeModules.claude-code
        self.homeModules.direnv
        self.homeModules.gemini-cli
        self.homeModules.git
        self.homeModules.nixvim
        self.homeModules.python
        self.homeModules.vscode
        self.homeModules.zed-editor
      ];

      home.packages = with pkgs; [
        age
        autoconf
        automake
        bc
        boost
        bottom
        bun
        bzip2
        clang-tools
        cmake
        devenv
        difftastic
        dust
        gcc
        ghq
        gnumake
        go
        gopls
        hexyl
        httpie
        hyperfine
        just
        k9s
        kubectl
        lazydocker
        lazygit
        libtool
        llvm
        lsof
        nix-diff
        nix-tree
        nodejs
        perf
        perl
        php
        pkg-config
        podman
        procs
        rstudio
        ruby
        shellcheck
        sqlite
        tmux
        tokei
        watchexec
        zlib
      ];
    };
}
