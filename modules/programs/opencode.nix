{
  flake.homeModules.opencode =
    { config, ... }:
    {
      programs.opencode = {
        enable = true;
        settings.plugin = [ config.services.meridian.opencode.pluginPath ];
      };

      xdg.configFile."opencode/plugin/strip-harness-prompt.ts".text = ''
        const CLAUDE_CODE_IDENTITY =
          "You are a Claude agent, built on Anthropic's Claude Agent SDK.";

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

            if (output.system[0] !== CLAUDE_CODE_IDENTITY) {
              output.system.unshift(CLAUDE_CODE_IDENTITY);
            }
          },
        });
      '';
    };
}
