{
  perSystem =
    { pkgs, ... }:
    {
      overlayAttrs.sage = pkgs.sage.override {
        requireSageTests = false;
      };
    };
}
