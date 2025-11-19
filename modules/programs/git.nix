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

        userName = "Mewski";
        userEmail = "mewski813@gmail.com";

        signing = {
          key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
          signByDefault = true;
        };

        settings = {
          gpg.format = "ssh";

          credential.helper = [
            ""
            "${lib.getExe pkgs.gh} auth git-credential"
          ];
        };
      };

      persist.files = [
        ".config/gh/hosts.yml"
      ];
    };
}
