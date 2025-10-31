{ self, ... }:
{
  flake.nixosModules.home-manager =
    { config, ... }:
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        users."${config.preferences.user.username}" = {
          imports = [ self.homeModules.zephyrus ];

          home.username = "${config.preferences.user.username}";
          home.homeDirectory = "/home/${config.preferences.user.username}";

          programs.home-manager.enable = true;

          home.stateVersion = "25.11";
        };
      };
    };
}
