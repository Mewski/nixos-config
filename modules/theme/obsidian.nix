{
  flake.homeModules.theme =
    {
      theme,
      scheme,
      ...
    }:
    {
      programs.obsidian.defaultSettings = {
        appearance = {
          interfaceFontFamily = theme.fonts.sansSerif.name;
          monospaceFontFamily = theme.fonts.monospace.name;
          baseFontSize = theme.fonts.sizes.application * 4.0 / 3.0;
        };

        cssSnippets = [
          {
            name = "Base16";
            text = ''
              .theme-${theme.polarity} {
                --color-base-00: ${scheme.withHashtag.base00};
                --color-base-05: ${scheme.withHashtag.base00};
                --color-base-10: ${scheme.withHashtag.base00};
                --color-base-20: ${scheme.withHashtag.base01};
                --color-base-25: ${scheme.withHashtag.base01};
                --color-base-30: ${scheme.withHashtag.base02};
                --color-base-35: ${scheme.withHashtag.base02};
                --color-base-40: ${scheme.withHashtag.base03};
                --color-base-50: ${scheme.withHashtag.base03};
                --color-base-60: ${scheme.withHashtag.base04};
                --color-base-70: ${scheme.withHashtag.base04};
                --color-base-100: ${scheme.withHashtag.base05};

                --color-accent: ${scheme.withHashtag.base0E};
                --color-accent-1: ${scheme.withHashtag.base0E};
              }
            '';
          }
        ];
      };

      programs.obsidian.vaults.notes.settings = {
        appearance = {
          interfaceFontFamily = theme.fonts.sansSerif.name;
          monospaceFontFamily = theme.fonts.monospace.name;
          baseFontSize = theme.fonts.sizes.application * 4.0 / 3.0;
        };

        cssSnippets = [
          {
            name = "Base16";
            text = ''
              .theme-${theme.polarity} {
                --color-base-00: ${scheme.withHashtag.base00};
                --color-base-05: ${scheme.withHashtag.base00};
                --color-base-10: ${scheme.withHashtag.base00};
                --color-base-20: ${scheme.withHashtag.base01};
                --color-base-25: ${scheme.withHashtag.base01};
                --color-base-30: ${scheme.withHashtag.base02};
                --color-base-35: ${scheme.withHashtag.base02};
                --color-base-40: ${scheme.withHashtag.base03};
                --color-base-50: ${scheme.withHashtag.base03};
                --color-base-60: ${scheme.withHashtag.base04};
                --color-base-70: ${scheme.withHashtag.base04};
                --color-base-100: ${scheme.withHashtag.base05};

                --color-accent: ${scheme.withHashtag.base0E};
                --color-accent-1: ${scheme.withHashtag.base0E};
              }
            '';
          }
        ];
      };
    };
}
