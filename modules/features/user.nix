{
  flake.nixosModules.user =
    { config, pkgs, ... }:
    {
      sops.secrets."users/${config.preferences.user.username}/passwd".neededForUsers = true;

      users = {
        mutableUsers = false;

        users.${config.preferences.user.username} = {
          isNormalUser = true;
          description = "${config.preferences.user.username}";
          # initialPassword = "mewski";
          hashedPasswordFile = config.sops.secrets."users/${config.preferences.user.username}/passwd".path;
          shell = pkgs.fish;
          extraGroups = [
            "networkmanager"
            "wheel"
          ];
        };
      };
    };
}
