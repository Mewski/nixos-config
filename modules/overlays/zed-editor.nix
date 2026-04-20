{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      overlayAttrs.zed-editor =
        (import inputs.nixpkgs-zed {
          inherit system;
          config.allowUnfree = true;
        }).zed-editor;
    };
}
