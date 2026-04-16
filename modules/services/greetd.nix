{
  flake.nixosModules.greetd =
    { config, lib, ... }:
    let
      primaryUser = builtins.head (builtins.attrNames config.home-manager.users);
    in
    lib.mkIf (config.desktop.session.command != null) {
      services.greetd = {
        enable = true;
        settings.initial_session = {
          user = primaryUser;
          command = config.desktop.session.command;
        };
      };
    };
}
