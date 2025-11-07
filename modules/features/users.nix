{
  flake.nixosModules.users =
    { config, ... }:
    {
      users = {
        mutableUsers = false;

        users.${config.preferences.user.username} = {
          isNormalUser = true;
          description = "${config.preferences.user.username}";
          initialPassword = "${config.preferences.user.username}";
          extraGroups = [
            "networkmanager"
            "wheel"
          ];
        };
      };
    };
}
