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
      trailofbits-skills = pkgs.fetchFromGitHub {
        owner = "trailofbits";
        repo = "skills";
        rev = "e8cc5baf9329ccb491bfa200e82eacbac83b1ead";
        hash = "sha256-ahuJDSIpUW2Zl5SbhyWXwMLFCYIjPygQPSfFeISXdHc=";
      };
      masriyan-cybersec = pkgs.fetchFromGitHub {
        owner = "Masriyan";
        repo = "Claude-Code-CyberSecurity-Skill";
        rev = "b10c1cc8db880de40ff92341855467130793d328";
        hash = "sha256-PK3OH2ONekPxGStMKAEceKHe4YGEsK5oy74HxLXP9ts=";
      };
      transilience-communitytools = pkgs.fetchFromGitHub {
        owner = "transilienceai";
        repo = "communitytools";
        rev = "e0fa8e9d709f28a1a73d9375f2087b6482da5bbd";
        hash = "sha256-nol2AljDnz59sQv7oJSFlfbOAyBm7nx3oR/McJlKsYI=";
      };
      trailofbits-offsec-plugins = [
        "dwarf-expert"
        "variant-analysis"
        "static-analysis"
        "insecure-defaults"
        "sharp-edges"
        "burpsuite-project-parser"
        "firebase-apk-scanner"
        "semgrep-rule-creator"
        "semgrep-rule-variant-creator"
        "yara-authoring"
        "entry-point-analyzer"
        "differential-review"
      ];
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
          ida_pro_mcp = {
            type = "stdio";
            command = "${pkgs.ida-pro-mcp}/bin/ida-pro-mcp";
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

        plugins =
          [
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
            transilience-communitytools
          ]
          ++ map (p: "${trailofbits-skills}/plugins/${p}") trailofbits-offsec-plugins;

        skills = "${masriyan-cybersec}/skills";

        settings = {
          includeCoAuthoredBy = false;
          skipDangerousModePermissionPrompt = true;
        };
      };
    };
}
