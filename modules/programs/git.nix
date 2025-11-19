{
  flake.homeModules.git =
    { config, ... }:
    {
      programs.git = {
        enable = true;

        settings = {
          user = {
            name = "Mewski";
            email = "mewski813@gmail.com";
          };

          gpg.format = "ssh";
        };

        signing = {
          key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
          signByDefault = true;
        };
      };

      programs.gh.enable = true;

      persist.files = [
        ".config/gh/hosts.yml"
      ];
    };
}
