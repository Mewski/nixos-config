{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      overlayAttrs = {
        pwndbg = inputs.pwndbg.packages.${system}.default;
        pwndbg-lldb = inputs.pwndbg.packages.${system}.pwndbg-lldb;
      };
    };
}
