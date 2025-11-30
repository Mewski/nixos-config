{
  flake.nixosModules.preferences =
    { lib, ... }:
    {
      options.preferences = {
        user = {
          username = lib.mkOption {
            type = lib.types.str;
            default = "mewski";
          };
          name = lib.mkOption {
            type = lib.types.str;
            default = "Mewski";
          };
        };
        theme = lib.mkOption {
          type = lib.types.str;
          default = "mountain";
        };
      };
    };
}
