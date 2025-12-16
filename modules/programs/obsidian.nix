{
  flake.homeModules.obsidian =
    { pkgs, ... }:
    let
      buildObsidianPlugin =
        {
          pname,
          version,
          owner,
          repo,
          rev ? version,
          sha256,
        }:
        pkgs.stdenv.mkDerivation {
          inherit pname version;

          src = pkgs.fetchFromGitHub {
            inherit
              owner
              repo
              rev
              sha256
              ;
          };

          installPhase = ''
            mkdir -p $out
            cp -r * $out/
          '';
        };

      excalidraw = buildObsidianPlugin {
        pname = "obsidian-excalidraw-plugin";
        version = "2.18.0";
        owner = "zsviczian";
        repo = "obsidian-excalidraw-plugin";
        sha256 = "sha256-4f8lUin3Cvo+7+Y06b0F7PcTbSOAAAGR5FYXqfLyVqA=";
      };

      latex = buildObsidianPlugin {
        pname = "obsidian-latex-suite";
        version = "1.9.8";
        owner = "artisticat1";
        repo = "obsidian-latex-suite";
        sha256 = "sha256-TtshzrHDnXG8xSGQvEmCrFLaEM8ckVrZLG1q6RBwHvo=";
      };
    in
    {
      programs.obsidian = {
        enable = true;

        defaultSettings.communityPlugins = [
          excalidraw
          latex
        ];

        vaults = {
          notes = {
            enable = true;
            target = "Documents/Notes";
          };
        };
      };
    };
}
