{
  flake.homeModules.vscode =
    { lib, pkgs, ... }:
    let
      nixfmt = lib.getExe pkgs.nixfmt;
      claude-code = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "claude-code";
          publisher = "anthropic";
          version = "2.1.37";
          sha256 = "sha256-Lc3TNj74BW/M1sK+bz/xw4L5B6KKBUh2uzXckScwPr8=";
        };
      };
    in
    {
      programs.vscode = {
        enable = true;
        mutableExtensionsDir = false;

        profiles.default.extensions = [
          claude-code
        ]
        ++ (with pkgs.vscode-extensions; [
          eamodio.gitlens
          github.copilot
          github.copilot-chat
          golang.go
          jnoortheen.nix-ide
          llvm-vs-code-extensions.vscode-clangd
          ms-azuretools.vscode-docker
          ms-python.python
          ms-python.vscode-pylance
          ms-toolsai.jupyter
          ms-vscode.cmake-tools
          ms-vscode.makefile-tools
          ms-vscode-remote.remote-containers
          ms-vscode-remote.remote-ssh
          ms-vscode-remote.remote-ssh-edit
          ms-vsliveshare.vsliveshare
          pkief.material-icon-theme
          fill-labs.dependi
          rust-lang.rust-analyzer
          tamasfe.even-better-toml
          vue.volar
          wakatime.vscode-wakatime
        ]);

        profiles.default.userSettings = {
          "editor.tabSize" = 2;
          "editor.insertSpaces" = true;
          "editor.formatOnSave" = true;
          "editor.bracketPairColorization.enabled" = true;
          "editor.guides.indentation" = true;
          "editor.guides.bracketPairs" = true;
          "editor.lineNumbers" = "on";
          "editor.minimap.enabled" = false;
          "editor.renderWhitespace" = "boundary";
          "editor.cursorBlinking" = "smooth";
          "editor.cursorSmoothCaretAnimation" = "off";
          "editor.smoothScrolling" = true;

          "files.autoSave" = "onFocusChange";
          "files.trimTrailingWhitespace" = true;
          "files.insertFinalNewline" = true;

          "workbench.startupEditor" = "none";
          "workbench.sideBar.location" = "left";
          "workbench.tree.indent" = 16;

          "window.restoreWindows" = "none";

          "git.enableSmartCommit" = true;
          "git.autofetch" = true;
          "diffEditor.wordWrap" = "on";

          "terminal.integrated.smoothScrolling" = true;

          "telemetry.telemetryLevel" = "off";

          "[nix]" = {
            "editor.defaultFormatter" = "jnoortheen.nix-ide";
          };

          "nix.enableLanguageServer" = true;
          "nix.serverPath" = lib.getExe pkgs.nil;
          "nix.serverSettings" = {
            nil = {
              formatting = {
                command = [ nixfmt ];
              };
            };
          };

          "clangd.arguments" = [
            "--background-index"
            "--clang-tidy"
            "--completion-style=detailed"
            "--function-arg-placeholders=0"
          ];
        };
      };
    };
}
