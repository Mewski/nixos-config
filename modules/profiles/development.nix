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
        self.homeModules.binary-ninja
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
        binutils
        boost
        bottom
        bun
        bzip2
        clang-tools
        cmake
        devenv
        difftastic
        dnsutils
        dust
        elfutils
        file
        gcc
        gdb
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
        ltrace
        nasm
        netcat-gnu
        nix-diff
        nix-tree
        nmap
        nodejs
        patchelf
        perf
        perl
        php
        pkg-config
        podman
        procs
        rstudio
        ruby
        rustc
        cargo
        rustfmt
        clippy
        rust-analyzer
        shellcheck
        socat
        sqlite
        strace
        tcpdump
        tmux
        tokei
        valgrind
        watchexec
        wireshark-cli
        zlib
      ];
    };
}
