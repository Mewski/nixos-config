{
  flake.homeModules.git =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      programs.git = {
        enable = true;

        settings = {
          user = {
            name = "Mewski";
            email = "mewski813@gmail.com";
          };

          gpg.format = "ssh";

          credential.helper = "${lib.getExe pkgs.gh} auth git-credential";
        };

        signing = {
          key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
          signByDefault = true;
        };
      };

      programs.gh = {
        enable = true;

        gitCredentialHelper.enable = true;
      };

      persist.files = [
        ".config/gh/hosts.yml"
      ];
    };
}
