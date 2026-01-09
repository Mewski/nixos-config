{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      overlayAttrs = inputs.binary-ninja.packages.${system} or { };
    };
}
