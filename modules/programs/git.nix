{
  flake.homeModules.git =
    { config, ... }:
    {
      programs = {
        git = {
          enable = true;
          lfs.enable = true;
          signing = {
            key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
            signByDefault = true;
          };
          settings = {
            user = {
              name = "Mewski";
              email = "mewski@mewski.dev";
            };
            gpg.format = "ssh";
          };
        };

        gh = {
          enable = true;
          gitCredentialHelper.enable = true;
        };
      };
    };
}
