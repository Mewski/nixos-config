{
  flake.nixosModules.preferences =
    { lib, ... }:
    {
      options.preferences = {
        user = {
          username = lib.mkOption {
            type = lib.types.str;
            default = "mewski";
            description = "Username for the primary user account";
          };
          name = lib.mkOption {
            type = lib.types.str;
            default = "Mewski";
            description = "Full name of the primary user";
          };
        };
        theme = lib.mkOption {
          type = lib.types.str;
          default = "lovelace";
          description = "Name of the colorscheme theme to use";
        };
      };
    };
}
