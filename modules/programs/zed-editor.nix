{
  flake.homeModules.zed-editor = {
    programs.zed-editor = {
      enable = true;

      userSettings = {
        icon_theme = "Material Icon Theme";
      };

      mutableUserSettings = false;
      mutableUserKeymaps = false;
      mutableUserTasks = false;

      extensions = [
        "material-icon-theme"
        "nix"
        "wakatime"
      ];
    };

    persist.directories = [
      ".local/share/zed"
    ];
  };
}
