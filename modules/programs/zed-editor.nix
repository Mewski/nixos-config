{
  flake.homeModules.zed-editor =
    { lib, pkgs, ... }:
    {
      programs.zed-editor = {
        enable = true;

        userSettings = {
          icon_theme = "Material Icon Theme";
          vim_mode = false;
          tab_size = 2;

          vim = {
            use_smartcase_find = true;
            use_system_clipboard = "always";
            toggle_relative_line_numbers = true;
          };

          telemetry = {
            metrics = false;
          };

          features = {
            edit_prediction_provider = "copilot";
          };

          lsp = {
            clangd = {
              binary = {
                arguments = [
                  "--background-index"
                  "--clang-tidy"
                  "--completion-style=detailed"
                  "--function-arg-placeholders=0"
                ];
              };
            };
            nil = {
              initialization_options = {
                formatting = {
                  command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
                };
              };
            };
            nixd = {
              initialization_options = {
                formatting = {
                  command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
                };
              };
            };
          };
        };

        mutableUserSettings = false;
        mutableUserKeymaps = false;
        mutableUserTasks = false;

        extensions = [
          "docker-compose"
          "dockerfile"
          "git-firefly"
          "go"
          "make"
          "material-icon-theme"
          "neocmake"
          "nix"
          "toml"
          "vue"
          "wakatime"
        ];
      };
    };
}
