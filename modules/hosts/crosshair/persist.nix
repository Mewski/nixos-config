{
  flake.nixosModules.crosshair =
    { lib, ... }:
    {
      options.persist = lib.mkOption {
        type = lib.types.submodule {
          options = {
            directories = lib.mkOption {
              type = lib.types.listOf lib.types.anything;
              default = [ ];
            };
            files = lib.mkOption {
              type = lib.types.listOf lib.types.anything;
              default = [ ];
            };
          };
        };
        default = { };
      };
    };

  flake.homeModules.crosshair =
    { lib, ... }:
    {
      options.persist = lib.mkOption {
        type = lib.types.submodule {
          options = {
            directories = lib.mkOption {
              type = lib.types.listOf lib.types.anything;
              default = [ ];
            };
            files = lib.mkOption {
              type = lib.types.listOf lib.types.anything;
              default = [ ];
            };
          };
        };
        default = { };
      };
    };
}
