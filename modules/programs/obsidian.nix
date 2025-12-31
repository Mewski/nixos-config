{
  flake.homeModules.obsidian = {
    programs.obsidian = {
      enable = true;
      defaultSettings.app.enabledPluginTrustedSources = true;
      vaults.notes = {
        enable = true;
        target = "Documents/Notes";
      };
    };
  };
}
