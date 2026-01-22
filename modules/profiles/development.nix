{ self, ... }:
{
  flake.nixosModules.development = {
    imports = [
      self.nixosModules.docker
      self.nixosModules.virtualization
    ];
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
        clang-tools
        cmake
        devenv
        difftastic
        gdb
        ghq
        gnumake
        just
        lazydocker
        lazygit
        lldb
        nix-output-monitor
        python3
        radare2
      ];
    };
}
