{
  flake.homeModules.niri =
    { ... }:
    let
      easeOutQuint = {
        curve = "cubic-bezier";
        curve-args = [
          0.23
          1.0
          0.32
          1.0
        ];
      };
    in
    {
      programs.niri.settings = {
        layout = {
          gaps = 6;

          border = {
            enable = true;
            width = 2;
          };

          focus-ring = {
            enable = true;
            width = 2;
          };

          shadow.enable = false;
        };

        animations = {
          window-open.kind.easing = easeOutQuint // {
            duration-ms = 410;
          };
          window-close.kind.easing = {
            duration-ms = 150;
            curve = "linear";
          };
          workspace-switch.kind.easing = easeOutQuint // {
            duration-ms = 380;
          };
          window-resize.kind.easing = easeOutQuint // {
            duration-ms = 480;
          };
          window-movement.kind.easing = easeOutQuint // {
            duration-ms = 480;
          };
          horizontal-view-movement.kind.easing = easeOutQuint // {
            duration-ms = 380;
          };
        };

        window-rules = [
          {
            geometry-corner-radius = {
              top-left = 8.0;
              top-right = 8.0;
              bottom-left = 8.0;
              bottom-right = 8.0;
            };
            clip-to-geometry = true;
          }
        ];
      };
    };
}
