{
  flake.nixosModules.greetd =
    { config, lib, pkgs, ... }:
    let
      tuigreet = lib.getExe pkgs.tuigreet;
    in
    lib.mkIf (config.desktop.session.command != null) {
      services.greetd = {
        enable = true;
        settings.default_session = {
          user = "greeter";
          command = "${tuigreet} --time --remember --remember-session --asterisks --cmd ${config.desktop.session.command}";
        };
      };
    };
}
