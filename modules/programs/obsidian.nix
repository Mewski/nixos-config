{
  flake.homeModules.obsidian =
    { pkgs, ... }:
    let
      mkObsidianPlugin =
        {
          name,
          version,
          mainJs,
          manifest,
          styles ? null,
        }:
        pkgs.stdenvNoCC.mkDerivation {
          pname = "obsidian-plugin-${name}";
          inherit version;

          dontUnpack = true;

          installPhase = ''
            mkdir -p $out
            cp ${mainJs} $out/main.js
            cp ${manifest} $out/manifest.json
            ${if styles != null then "cp ${styles} $out/styles.css" else ""}
          '';
        };

      excalidraw = mkObsidianPlugin {
        name = "excalidraw";
        version = "2.20.0";
        mainJs = pkgs.fetchurl {
          url = "https://github.com/zsviczian/obsidian-excalidraw-plugin/releases/download/2.20.0/main.js";
          hash = "sha256-7zqgTOVCICGG0p8nsu2GxSXVL0ZJMZ63u3fkK+jTT3M=";
        };
        manifest = pkgs.fetchurl {
          url = "https://github.com/zsviczian/obsidian-excalidraw-plugin/releases/download/2.20.0/manifest.json";
          hash = "sha256-0xa53Fou1H2x/NBjlQKOv/Rdki52UEzu6UT+axGF/Mc=";
        };
        styles = pkgs.fetchurl {
          url = "https://github.com/zsviczian/obsidian-excalidraw-plugin/releases/download/2.20.0/styles.css";
          hash = "sha256-TGVZY5H+ZAji+ssnbc4Rtkyv1T1jUx+2gHGXUFjdd1E=";
        };
      };

      latex-suite = mkObsidianPlugin {
        name = "latex-suite";
        version = "1.9.8";
        mainJs = pkgs.fetchurl {
          url = "https://github.com/artisticat1/obsidian-latex-suite/releases/download/1.9.8/main.js";
          hash = "sha256-2ceWgQ9TvdOPXAWFfL9SbrJ0zM3j9iig54+eaWGMqu0=";
        };
        manifest = pkgs.fetchurl {
          url = "https://github.com/artisticat1/obsidian-latex-suite/releases/download/1.9.8/manifest.json";
          hash = "sha256-BG0MBrQXM5ekMf1sP3k6sz2kKkY+aD23ZiN3U9u1BPE=";
        };
        styles = pkgs.fetchurl {
          url = "https://github.com/artisticat1/obsidian-latex-suite/releases/download/1.9.8/styles.css";
          hash = "sha256-832XEDMzZEHqXmb5GdevGjdjh9a+ZOJJcxqMBekMSM4=";
        };
      };

      languagetool = mkObsidianPlugin {
        name = "languagetool";
        version = "0.3.7";
        mainJs = pkgs.fetchurl {
          url = "https://github.com/Clemens-E/obsidian-languagetool-plugin/releases/download/0.3.7/main.js";
          hash = "sha256-iGZs62ymYxUNLoK+O73MoLU8KggtLaSa/3RMJ2fLGKE=";
        };
        manifest = pkgs.fetchurl {
          url = "https://github.com/Clemens-E/obsidian-languagetool-plugin/releases/download/0.3.7/manifest.json";
          hash = "sha256-0Rci7MRPOQsvf8/L/idQB19nefV8eVsm6SDaK2k+yCA=";
        };
        styles = pkgs.fetchurl {
          url = "https://github.com/Clemens-E/obsidian-languagetool-plugin/releases/download/0.3.7/styles.css";
          hash = "sha256-8RnXm7GrNJ/jyJL7At89RexPIj7VNHlEvjMn5LYkmFo=";
        };
      };

      brat = mkObsidianPlugin {
        name = "brat";
        version = "2.0.2";
        mainJs = pkgs.fetchurl {
          url = "https://github.com/TfTHacker/obsidian42-brat/releases/download/2.0.2/main.js";
          hash = "sha256-+TRfrMfhNUxvNr+Rh205k+WKqssxgtfML3ISy3leBmY=";
        };
        manifest = pkgs.fetchurl {
          url = "https://github.com/TfTHacker/obsidian42-brat/releases/download/2.0.2/manifest.json";
          hash = "sha256-cvbIhOAn7MBHJRF0AtXDnfPSw+xiKTyTQq3yrZ/XPyc=";
        };
        styles = pkgs.fetchurl {
          url = "https://github.com/TfTHacker/obsidian42-brat/releases/download/2.0.2/styles.css";
          hash = "sha256-ruUC02dBfQl12DqczUdp09KvBH75UWJBriC4apDevDA=";
        };
      };

      dataview = mkObsidianPlugin {
        name = "dataview";
        version = "0.5.67";
        mainJs = pkgs.fetchurl {
          url = "https://github.com/blacksmithgu/obsidian-dataview/releases/download/0.5.67/main.js";
          hash = "sha256-YyYDb51+5z2yJtXKUeB3Sx4YG+gJZWcn/xvQSDovY2s=";
        };
        manifest = pkgs.fetchurl {
          url = "https://github.com/blacksmithgu/obsidian-dataview/releases/download/0.5.67/manifest.json";
          hash = "sha256-P1XnPUPruazBaKbXsguFS29EXcvoVwWIVLHbhLgkqBw=";
        };
        styles = pkgs.fetchurl {
          url = "https://github.com/blacksmithgu/obsidian-dataview/releases/download/0.5.67/styles.css";
          hash = "sha256-z8T/vXpQffcNan0khWGks5v2y1RbuEeKWoCsju4YxGw=";
        };
      };

      calendar = mkObsidianPlugin {
        name = "calendar";
        version = "1.5.10";
        mainJs = pkgs.fetchurl {
          url = "https://github.com/liamcain/obsidian-calendar-plugin/releases/download/1.5.10/main.js";
          hash = "sha256-f7M56c+f2+WoAforirhbNmtbN3f70ZPLyHKLwncR0SU=";
        };
        manifest = pkgs.fetchurl {
          url = "https://github.com/liamcain/obsidian-calendar-plugin/releases/download/1.5.10/manifest.json";
          hash = "sha256-8+lYEzhkhRK6oS1bRYSQ9/02eRj3vba9hhcc5Xvn0Is=";
        };
      };

      editor-syntax-highlight = mkObsidianPlugin {
        name = "editor-syntax-highlight";
        version = "0.1.3";
        mainJs = pkgs.fetchurl {
          url = "https://github.com/deathau/cm-editor-syntax-highlight-obsidian/releases/download/0.1.3/main.js";
          hash = "sha256-3nM3xnQs/JneecQbX66O8IXw1DZcQU8riF5qaSxiPw8=";
        };
        manifest = pkgs.fetchurl {
          url = "https://github.com/deathau/cm-editor-syntax-highlight-obsidian/releases/download/0.1.3/manifest.json";
          hash = "sha256-CqHc2LPcAb1t4PE5k5FsoEwqkd+iYZqg7+gj1/YGBEo=";
        };
        styles = pkgs.fetchurl {
          url = "https://github.com/deathau/cm-editor-syntax-highlight-obsidian/releases/download/0.1.3/styles.css";
          hash = "sha256-P2eaQQvyqaVQISq1zvhepPRrhlWDg49VsSgu+SVkx3k=";
        };
      };
    in
    {
      programs.obsidian = {
        enable = true;
        defaultSettings.app.enabledPluginTrustedSources = true;

        defaultSettings.communityPlugins = [
          { pkg = excalidraw; }
          { pkg = latex-suite; }
          { pkg = languagetool; }
          { pkg = editor-syntax-highlight; }
          { pkg = dataview; }
          { pkg = calendar; }
          { pkg = brat; }
        ];

        vaults.notes = {
          enable = true;
          target = "Documents/Notes";
        };
      };
    };
}
