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
        self.homeModules.nixvim
        self.homeModules.opencode
        self.homeModules.python
        self.homeModules.vscode
        self.homeModules.zed-editor
      ];

      home.packages = with pkgs; [
        age
        android-tools
        apktool
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
        burpsuite
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
        exploitdb
        ffuf
        file
        frida-tools
        gcc
        gdb
        ghidra
        ghq
        gitleaks
        gnumake
        go
        gopls
        hashcat
        hash-identifier
        hexyl
        httpie
        hyperfine
        jadx
        john
        just
        jwt-cli
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
        nuclei
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
        pwndbg
        radare2
        rizin
        rstudio
        ruby
        rust-analyzer
        rustc
        rustfmt
        screen
        seclists
        shellcheck
        sigrok-cli
        socat
        sqlite
        sqlmap
        step-cli
        strace
        testssl
        tmux
        tokei
        trufflehog
        upx
        uv
        valgrind
        wabt
        watchexec
        wireshark-cli
        yara
        zlib
      ];

      home.sessionVariables.SECLISTS = "${pkgs.seclists}/share/wordlists/seclists";
    };
}
