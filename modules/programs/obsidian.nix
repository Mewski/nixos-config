{
  flake.homeModules.obsidian = {
    programs.obsidian = {
      enable = true;

      vaults = {
        notes = {
          enable = true;
          target = "Documents/Notes";
        };
      };
    };
  };
}
