{
  flake.nixosModules.persist =
    { lib, ... }:
    {
      options.persist = {
        directories = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "Directories to persist in /persist/home";
        };
        files = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "Files to persist in /persist/home";
        };
      };
    };

  flake.homeManagerModules.persist =
    { lib, ... }:
    {
      options.persist = {
        directories = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "Directories to persist in /persist/home";
        };
        files = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "Files to persist in /persist/home";
        };
      };
    };
}
