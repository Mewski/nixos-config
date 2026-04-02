{
  flake.homeModules.claude-code =
    { pkgs, ... }:
    let
      claude-plugins-official = pkgs.fetchFromGitHub {
        owner = "anthropics";
        repo = "claude-plugins-official";
        rev = "b091cb4179d3b62a6e2a39910461c7ec7165b1ef";
        hash = "sha256-uKDVcw6C1uzpiIY+hjgHxr4AU9wM1KF7t3v6zd9XBHk=";
      };
    in
    {
      programs.claude-code = {
        enable = true;

        rules = {
          token-efficient = ''
            Think before acting. Read existing files before writing code.
            Be concise in output but thorough in reasoning.
            Prefer editing over rewriting whole files.
            Do not re-read files you have already read unless the file may have changed.
            Test your code before declaring done.
            No sycophantic openers or closing fluff.
            Keep solutions simple and direct.
            User instructions always override this file.
          '';
        };

        mcpServers = {
          binary_ninja_mcp = {
            type = "stdio";
            command = "${pkgs.nodejs_latest}/bin/npx";
            args = [
              "-y"
              "binary-ninja-mcp"
            ];
            timeout = 1800;
          };
          gdb = {
            type = "stdio";
            command = "${pkgs.nodejs_latest}/bin/npx";
            args = [
              "-y"
              "mcp-gdb"
            ];
            timeout = 1800;
          };
        };

        plugins = [
          (pkgs.fetchFromGitHub {
            owner = "obra";
            repo = "superpowers";
            rev = "b7a8f76985f1e93e75dd2f2a3b424dc731bd9d37";
            hash = "sha256-hGEMwmSojy3cNtUQvB5djExlD39O2dwcnLOMUNaVIHg=";
          })
          "${claude-plugins-official}/plugins/clangd-lsp"
          "${claude-plugins-official}/plugins/frontend-design"
          "${claude-plugins-official}/plugins/rust-analyzer-lsp"
          "${claude-plugins-official}/plugins/typescript-lsp"
        ];

        settings = {
          includeCoAuthoredBy = false;
          skipDangerousModePermissionPrompt = true;
        };
      };
    };
}
