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
        self.homeModules.vscode
        self.homeModules.zed-editor
      ];

      home.packages = with pkgs; [
        bc
        clang-tools
        cmake
        devenv
        difftastic
        gcc
        gdb
        ghq
        gnumake
        just
        lazydocker
        lazygit
        lldb
        nix-output-monitor
        proxychains-ng
        (python3.withPackages (
          ps: with ps; [
            numpy
            pip
            requests
          ]
        ))
        radare2
        rstudio
        vt-cli
      ];
    };
}
