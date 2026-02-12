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
        ghq
        gnumake
        just
        lazydocker
        lazygit
        nix-output-monitor
        nodejs
        (python3.withPackages (
          ps: with ps; [
            numpy
            pip
            requests
          ]
        ))
        rstudio
      ];
    };
}
