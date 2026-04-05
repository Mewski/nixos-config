{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      overlayAttrs.ida-pro-wayland = inputs.ida-pro.packages.${system}.ida-pro-wayland;
    };
}
