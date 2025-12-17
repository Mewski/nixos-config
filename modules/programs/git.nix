{
  flake.homeModules.git =
    { config, ... }:
    {
      home.file.".ssh/allowed_signers".text = ''
        mewski813@gmail.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJS08cEqHN1mAFtpou4jjJIxA//cqaerTk1cEnMBwe+f Mewski
      '';

      programs.git = {
        enable = true;

        lfs.enable = true;

        settings = {
          user = {
            name = "Mewski";
            email = "mewski813@gmail.com";
          };

          gpg = {
            format = "ssh";
            ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
          };
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
    };
}
