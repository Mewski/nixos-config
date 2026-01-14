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
        self.homeModules.zed-editor
      ];

      home.packages = with pkgs; [
        clang-tools
        devenv
        difftastic
        gdb
        ghq
        just
        lazydocker
        lazygit
        lldb
        nix-output-monitor
        radare2
      ];
    };
}
