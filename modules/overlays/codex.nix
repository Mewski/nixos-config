{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      overlayAttrs.codex = inputs.codex-cli.packages.${system}.default;
    };
}
