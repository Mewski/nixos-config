{
  flake.homeModules.opencode =
    { config, pkgs, ... }:
    let
      claude-plugins-official = pkgs.fetchFromGitHub {
        owner = "anthropics";
        repo = "claude-plugins-official";
        rev = "b091cb4179d3b62a6e2a39910461c7ec7165b1ef";
        hash = "sha256-uKDVcw6C1uzpiIY+hjgHxr4AU9wM1KF7t3v6zd9XBHk=";
      };
      superpowers = pkgs.fetchFromGitHub {
        owner = "obra";
        repo = "superpowers";
        rev = "b7a8f76985f1e93e75dd2f2a3b424dc731bd9d37";
        hash = "sha256-hGEMwmSojy3cNtUQvB5djExlD39O2dwcnLOMUNaVIHg=";
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
      trailofbits-offsec-skills = [
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
      programs.opencode = {
        enable = true;
        settings = {
          plugin = [ config.services.meridian.opencode.pluginPath ];
          provider.anthropic.options = {
            baseURL = "http://${config.services.meridian.settings.host}:${toString config.services.meridian.settings.port}";
            apiKey = "meridian";
          };
          permission = {
            webfetch = "allow";
            websearch = "allow";
          };
          mcp = {
            binary_ninja_mcp = {
              type = "local";
              command = [
                "${pkgs.nodejs_latest}/bin/npx"
                "-y"
                "binary-ninja-mcp"
              ];
              enabled = true;
              timeout = 1800000;
            };
            ida_pro_mcp = {
              type = "local";
              command = [ "${pkgs.ida-pro-mcp}/bin/ida-pro-mcp" ];
              enabled = true;
              timeout = 1800000;
            };
            gdb = {
              type = "local";
              command = [
                "${pkgs.nodejs_latest}/bin/npx"
                "-y"
                "mcp-gdb"
              ];
              enabled = true;
              timeout = 1800000;
            };
          };
        };
      };

      home.sessionVariables.OPENCODE_ENABLE_EXA = "true";

      xdg.configFile."opencode/skills".source = pkgs.symlinkJoin {
        name = "opencode-skills";
        paths =
          [
            "${superpowers}/skills"
            "${claude-plugins-official}/plugins/frontend-design/skills"
            "${masriyan-cybersec}/skills"
            "${transilience-communitytools}/skills"
          ]
          ++ map (s: "${trailofbits-skills}/plugins/${s}/skills") trailofbits-offsec-skills;
      };

      xdg.configFile."opencode/plugin/strip-harness-prompt.ts".text = ''
        const CLAUDE_CODE_IDENTITY_LINE =
          "You are a Claude agent, built on Anthropic's Claude Agent SDK.";

        const CLAUDE_CODE_STANZA = [
          CLAUDE_CODE_IDENTITY_LINE,
          "You are an interactive agent that helps users with software engineering tasks. Use the instructions below and the tools available to you to assist the user.",
          "",
          "If the user asks for help or wants to give feedback inform them of the following:",
          " - /help: Get help with using Claude Code",
          " - To give feedback, users should report the issue at https://github.com/anthropics/claude-code/issues",
          "",
          "Claude Code is available as a CLI in the terminal, desktop app (Mac/Windows), web app (claude.ai/code), and IDE extensions (VS Code, JetBrains).",
        ].join("\n");

        const IDENTITY_PREFIXES = ["You are opencode", "You are OpenCode"];

        const PARAGRAPH_REMOVAL_ANCHORS = [
          "github.com/anomalyco/opencode",
          "github.com/sst/opencode",
          "opencode.ai/docs",
        ];

        const TEXT_REPLACEMENTS = [
          { match: /\bOpenCode\b/g, replacement: "the assistant" },
          { match: /\bopencode\b/g, replacement: "the assistant" },
        ];

        function sanitize(text) {
          const paragraphs = text.split(/\n\n+/);
          const kept = paragraphs.filter((p) => {
            for (const prefix of IDENTITY_PREFIXES) {
              if (p.startsWith(prefix)) return false;
            }
            for (const anchor of PARAGRAPH_REMOVAL_ANCHORS) {
              if (p.includes(anchor)) return false;
            }
            return true;
          });
          let result = kept.join("\n\n");
          for (const rule of TEXT_REPLACEMENTS) {
            result = result.replace(rule.match, rule.replacement);
          }
          return result.trim();
        }

        export const StripHarnessPrompt = async () => ({
          "experimental.chat.system.transform": async (input, output) => {
            if (input.model?.providerID !== "anthropic") return;

            for (let i = output.system.length - 1; i >= 0; i--) {
              const part = output.system[i];
              if (typeof part !== "string") continue;
              const cleaned = sanitize(part);
              if (!cleaned) output.system.splice(i, 1);
              else output.system[i] = cleaned;
            }

            if (!output.system[0]?.startsWith(CLAUDE_CODE_IDENTITY_LINE)) {
              output.system.unshift(CLAUDE_CODE_STANZA);
            }
          },
        });
      '';
    };
}
