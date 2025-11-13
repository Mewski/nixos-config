{
  flake.nixosModules.user =
    { config, pkgs, ... }:
    {
      users = {
        mutableUsers = false;

        users.${config.preferences.user.username} = {
          isNormalUser = true;
          description = "${config.preferences.user.username}";
          initialPassword = "${config.preferences.user.username}";
          shell = pkgs.fish;
          extraGroups = [
            "networkmanager"
            "wheel"
          ];
        };
      };
    };
}
