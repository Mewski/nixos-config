{
  flake.nixosModules.greetd =
    { config, lib, ... }:
    let
      primaryUser = builtins.head (builtins.attrNames config.home-manager.users);
      session = {
        user = primaryUser;
        command = config.desktop.session.command;
      };
    in
    lib.mkIf (config.desktop.session.command != null) {
      services.greetd = {
        enable = true;
        settings = {
          default_session = session;
          initial_session = session;
        };
      };
    };
}
