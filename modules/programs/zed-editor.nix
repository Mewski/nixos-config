{
  flake.homeModules.zed-editor = {
    programs.zed-editor = {
      enable = true;

      userSettings = {
        icon_theme = "Material Icon Theme";
      };

      extensions = [
        "material-icon-theme"
        "nix"
        "wakatime"
      ];
    };

    persist.directories = [
      ".config/zed"
      ".local/share/zed"
    ];
  };
}
