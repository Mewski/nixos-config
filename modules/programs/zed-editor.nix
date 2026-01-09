{
  flake.homeModules.zed-editor =
    { lib, pkgs, ... }:
    let
      nixfmt = lib.getExe pkgs.nixfmt;
    in
    {
      programs.zed-editor = {
        enable = true;
        mutableUserSettings = false;
        mutableUserKeymaps = false;
        mutableUserTasks = false;

        userSettings = {
          icon_theme = "Material Icon Theme";
          vim_mode = false;
          tab_size = 2;

          languages."C++" = {
            format_on_save = "on";
          };

          vim = {
            use_smartcase_find = true;
            use_system_clipboard = "always";
            toggle_relative_line_numbers = true;
          };

          telemetry.metrics = false;
          features.edit_prediction_provider = "copilot";

          lsp = {
            clangd.binary.arguments = [
              "--background-index"
              "--clang-tidy"
              "--completion-style=detailed"
              "--function-arg-placeholders=0"
            ];
            nil.initialization_options.formatting.command = [ nixfmt ];
            nixd.initialization_options.formatting.command = [ nixfmt ];
          };
        };

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
