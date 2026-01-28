{
  flake.nixosModules.astraeus =
    { config, ... }:
    {
      users = {
        mutableUsers = false;
        users.mewski = {
          isNormalUser = true;
          description = "Mewski";
          hashedPasswordFile = config.sops.secrets."users/mewski/hashed_password".path;
          extraGroups = [ "wheel" ];
        };
      };
    };
}
