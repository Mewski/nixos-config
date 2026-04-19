{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      overlayAttrs.claude-code = inputs.claude-code.packages.${system}.default;
    };
}
