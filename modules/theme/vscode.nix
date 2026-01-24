{
  flake.homeModules.vscode =
    { theme, ... }:
    {
      programs.vscode = {
        enable = true;

        profiles.default.userSettings = {
          "editor.fontFamily" = "'${theme.fonts.monospace.name}', monospace";
          "editor.fontSize" = theme.fonts.sizes.terminal * 4.0 / 3.0;
          "editor.fontLigatures" = true;
          "terminal.integrated.fontFamily" = "'${theme.fonts.monospace.name}'";
          "terminal.integrated.fontSize" = theme.fonts.sizes.terminal * 4.0 / 3.0;

          "workbench.colorTheme" = "Default Dark Modern";
          "workbench.iconTheme" = "material-icon-theme";
        };
      };
    };
}
