{
  flake.homeModules.git =
    { config, ... }:
    {
      programs.git = {
        enable = true;

        userName = "Mewski";
        userEmail = "mewski813@gmail.com";

        signing = {
          key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
          signByDefault = true;
        };

        extraConfig.gpg.format = "ssh";
      };

      programs.gh = {
        enable = true;

        hosts = {
          "github.com" = {
            user = "Mewski";
          };
        };

        gitCredentialHelper = {
          enable = true;
        };
      };

      persist.directories = [
        ".config/gh"
      ];
    };
}
