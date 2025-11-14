{ self, ... }:
{
  flake.nixosModules.theme =
    { config, lib, ... }:
    {
      imports = [
        self.nixosModules."${config.preferences.theme}"
      ];

      mkOpacityHex =
        opacity:
        let
          value =
            lib.throwIfNot (opacity >= 0 && opacity <= 1)
              "value must be between 0 and 1 (inclusive): ${toString opacity}"
              (builtins.floor (opacity * 255 + 0.5));
        in
        lib.fixedWidthString 2 (c: "${lib.toHexString c}") value;
    };
}
