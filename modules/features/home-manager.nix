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
          scheme = config.scheme;
          cursor = config.cursor;
          fonts = config.fonts;
          opacity = config.opacity;
          polarity = config.polarity;
        };

        sharedModules = [
          self.homeModules.persist
        ];

        users.${config.preferences.user.username} = {
          imports = [ self.homeModules.zephyrus ];

          home.username = "${config.preferences.user.username}";
          home.homeDirectory = "/home/${config.preferences.user.username}";

          programs.home-manager.enable = true;

          home.stateVersion = "25.11";
        };
      };

      persist = config.home-manager.users.${config.preferences.user.username}.persist;
    };
}
