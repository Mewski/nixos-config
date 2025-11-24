{
  flake.homeModules.zed-editor = {
    programs.zed-editor = {
      enable = true;

      userSettings = {
        icon_theme = "Material Icon Theme";
        vim_mode = true;

        telemetry = {
          metrics = false;
        };

        features = {
          copilot = false;
          edit_prediction_provider = "copilot";
        };
      };

      mutableUserSettings = false;
      mutableUserKeymaps = false;
      mutableUserTasks = false;

      extensions = [
        "material-icon-theme"
        "nix"
        "wakatime"
        "git-firefly"
        "make"
        "dockerfile"
        "docker-compose"
      ];
    };

    persist.directories = [
      ".local/share/zed"
    ];
  };
}
