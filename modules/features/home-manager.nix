{ inputs, self, ... }:
{
  flake.nixosModules.home-manager =
    { config, ... }:
    {
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        extraSpecialArgs = {
          preferences = config.preferences;
          theme = config.theme;
          scheme = config.scheme;
        };

        sharedModules = [ self.homeModules.${config.networking.hostName} ];

        users.${config.preferences.user.username} = {
          home.username = "${config.preferences.user.username}";
          home.homeDirectory = "/home/${config.preferences.user.username}";

          programs.home-manager.enable = true;

          home.stateVersion = "25.11";
        };
      };
    };
}
