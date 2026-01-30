{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      overlayAttrs = inputs.proxmox-nixos.overlays.${system} null null;
    };
}
