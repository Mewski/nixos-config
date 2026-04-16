{
  perSystem =
    { pkgs, ... }:
    {
      overlayAttrs.rstudio = pkgs.rstudio.override {
        electron_38 = pkgs.electron_38.overrideAttrs (old: {
          meta = old.meta // {
            knownVulnerabilities = [ ];
          };
        });
      };
    };
}
