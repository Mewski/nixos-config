{ self, ... }:
{
  flake.nixosModules.development = {
    imports = [ self.nixosModules.virtualization ];

    virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
    };

    home-manager.sharedModules = [ self.homeModules.development ];
  };

  flake.homeModules.development =
    { pkgs, ... }:
    {
      imports = [
        self.homeModules.binary-ninja
        self.homeModules.ida-pro
        self.homeModules.claude-code
        self.homeModules.direnv
        self.homeModules.gemini-cli
        self.homeModules.git
        self.homeModules.meridian
        self.homeModules.nixvim
        self.homeModules.opencode
        self.homeModules.python
        self.homeModules.vscode
        self.homeModules.zed-editor
      ];

      home.packages = with pkgs; [
        age
        android-tools
        autoconf
        automake
        avrdude
        bc
        bindiff
        binutils
        binwalk
        boost
        bottom
        bun
        bzip2
        cargo
        clang-tools
        clippy
        cmake
        devenv
        dfu-util
        difftastic
        dnsutils
        dust
        elfutils
        esptool
        exiftool
        file
        gcc
        gdb
        ghidra
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
        minicom
        nasm
        netcat-gnu
        nix-diff
        nix-tree
        nmap
        nodejs
        openocd
        patchelf
        perf
        perl
        php
        pkg-config
        podman
        probe-rs-tools
        procs
        pulseview
        rstudio
        ruby
        rust-analyzer
        rustc
        rustfmt
        screen
        shellcheck
        sigrok-cli
        socat
        sqlite
        strace
        tcpdump
        tmux
        tokei
        uv
        valgrind
        wabt
        watchexec
        wireshark-cli
        zlib
      ];
    };
}
