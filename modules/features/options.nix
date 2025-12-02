{ inputs, ... }:
{
  flake.nixosModules.options =
    { lib, ... }:
    {
      imports = [ inputs.base16.nixosModule ];

      options = {
        preferences = {
          user = {
            username = lib.mkOption { type = lib.types.str; };
            name = lib.mkOption { type = lib.types.str; };
          };

          theme = lib.mkOption { type = lib.types.str; };
        };

        theme = {
          polarity = lib.mkOption {
            type = lib.types.enum [
              "dark"
              "light"
            ];
          };

          cursor = {
            name = lib.mkOption { type = lib.types.str; };
            package = lib.mkOption { type = lib.types.package; };
            size = lib.mkOption { type = lib.types.int; };
          };

          fonts = {
            emoji = {
              name = lib.mkOption { type = lib.types.str; };
              package = lib.mkOption { type = lib.types.package; };
            };

            monospace = {
              name = lib.mkOption { type = lib.types.str; };
              package = lib.mkOption { type = lib.types.package; };
            };

            sansSerif = {
              name = lib.mkOption { type = lib.types.str; };
              package = lib.mkOption { type = lib.types.package; };
            };

            serif = {
              name = lib.mkOption { type = lib.types.str; };
              package = lib.mkOption { type = lib.types.package; };
            };

            sizes = {
              desktop = lib.mkOption { type = lib.types.int; };
              application = lib.mkOption { type = lib.types.int; };
              terminal = lib.mkOption { type = lib.types.int; };
              popups = lib.mkOption { type = lib.types.int; };
            };
          };

          opacity = {
            desktop = lib.mkOption { type = lib.types.float; };
            application = lib.mkOption { type = lib.types.float; };
            terminal = lib.mkOption { type = lib.types.float; };
            popups = lib.mkOption { type = lib.types.float; };
          };
        };
      };
    };
}
