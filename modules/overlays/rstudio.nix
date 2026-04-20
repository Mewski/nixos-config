{
  perSystem =
    { pkgs, ... }:
    {
      overlayAttrs.rstudio = pkgs.rstudio.override {
        nodejs-slim = pkgs.nodejs;
        electron_38 = pkgs.electron_38.overrideAttrs (old: {
          meta = old.meta // {
            knownVulnerabilities = [ ];
          };
        });
      };
    };
}
