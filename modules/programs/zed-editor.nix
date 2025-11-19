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
  };
}
