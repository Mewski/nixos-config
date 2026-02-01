{
  flake.homeModules.vscode =
    { lib, pkgs, ... }:
    let
      nixfmt = lib.getExe pkgs.nixfmt;
    in
    {
      programs.vscode = {
        enable = true;
        mutableExtensionsDir = false;

        profiles.default.extensions = with pkgs.vscode-extensions; [
          eamodio.gitlens
          github.copilot
          github.copilot-chat
          golang.go
          jnoortheen.nix-ide
          llvm-vs-code-extensions.vscode-clangd
          ms-azuretools.vscode-docker
          ms-vscode.cmake-tools
          ms-vscode-remote.remote-containers
          ms-vscode-remote.remote-ssh
          ms-vscode-remote.remote-ssh-edit
          ms-vsliveshare.vsliveshare
          pkief.material-icon-theme
          tamasfe.even-better-toml
          vue.volar
          wakatime.vscode-wakatime
        ];

        profiles.default.userSettings = {
          "editor.tabSize" = 2;
          "editor.insertSpaces" = true;
          "editor.formatOnSave" = true;
          "editor.bracketPairColorization.enabled" = true;
          "editor.guides.indentation" = true;
          "editor.guides.bracketPairs" = true;
          "editor.lineNumbers" = "relative";
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
