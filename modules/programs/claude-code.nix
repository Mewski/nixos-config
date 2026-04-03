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
