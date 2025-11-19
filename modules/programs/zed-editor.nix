{
  flake.homeModules.zed-editor =
    { polarity, ... }:
    {
      programs.zed-editor = {
        enable = true;

        settings = {
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
