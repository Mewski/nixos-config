{
  flake.homeModules.zed-editor = {
    programs.zed-editor = {
      enable = true;

      userSettings = {
        icon_theme = "Material Icon Theme";
        vim_mode = false;
        cursor_blink = false;

        vim = {
          use_smartcase_find = true;
          use_system_clipboard = "always";
          toggle_relative_line_numbers = true;
        };

        telemetry = {
          metrics = false;
        };

        features = {
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
        "vue"
      ];
    };
  };
}
