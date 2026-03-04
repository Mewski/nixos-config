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
        autoconf
        automake
        bc
        boost
        bun
        bzip2
        clang-tools
        cmake
        devenv
        gcc
        gnumake
        go
        gopls
        just
        libtool
        llvm
        nodejs
        pkg-config
        zlib
        difftastic
        ghq
        lazydocker
        lazygit
        hexyl
        hyperfine
        tokei
        watchexec
        bottom
        dust
        lsof
        perf
        procs
        rstudio
        sqlite
        k9s
        kubectl
        podman
      ];
    };
}
