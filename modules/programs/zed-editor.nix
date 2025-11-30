{
  flake.homeModules.zed-editor = {
    programs.zed-editor = {
      enable = true;

      userSettings = {
        icon_theme = "Material Icon Theme";
        vim_mode = false;

        telemetry = {
          metrics = false;
        };

        features = {
          copilot = true;
          edit_prediction_provider = "zed";
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
        "toml"
        "go"
      ];
    };

    persist.directories = [
      ".local/share/zed"
      ".claude"
    ];
  };
}
