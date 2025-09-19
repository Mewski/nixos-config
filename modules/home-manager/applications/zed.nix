{ ... }:

{
  # Modern code editor with collaborative features and AI integration
  programs.zed-editor = {
    enable = true;

    extensions = [
      # Language Support
      "nix"
      "toml"
      "html"
      "vue"

      # Development Tools
      "dockerfile"
      "docker-compose"
      "pylsp"

      # Themes and Visual Enhancements
      "material-icon-theme"
      "fleet-themes"

      # Productivity and Analytics
      "wakatime"
    ];
  };
}
