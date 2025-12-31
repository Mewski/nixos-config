{
  flake.nixosModules.astraeus =
    { config, ... }:
    {
      sops.secrets."users/mewski/hashed_password".neededForUsers = true;

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
