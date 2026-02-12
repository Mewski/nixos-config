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
        difftastic
        gcc
        ghq
        gnumake
        just
        lazydocker
        lazygit
        libtool
        llvm
        nix-output-monitor
        nodejs
        perf
        pkg-config
        rstudio
        sqlite
        zlib
      ];
    };
}
