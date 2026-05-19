{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    let
      packages = inputs.pwndbg.packages.${system};
    in
    {
      overlayAttrs = {
        pwndbg = packages.default;
        inherit (packages) pwndbg-lldb;
      };
    };
}
