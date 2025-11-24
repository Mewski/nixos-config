{
  flake.nixosModules.zephyrus =
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

  flake.homeModules.zephyrus =
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
