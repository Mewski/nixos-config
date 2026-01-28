{
  flake.nixosModules.astraeus = {
    users.users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJS08cEqHN1mAFtpou4jjJIxA//cqaerTk1cEnMBwe+f Mewski"
    ];
  };
}
