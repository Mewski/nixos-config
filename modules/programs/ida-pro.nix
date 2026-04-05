{
  flake.homeModules.ida-pro =
    { lib, pkgs, ... }:
    {
      home = {
        packages = [
          pkgs.ida-pro-wayland
          pkgs.ida-pro-mcp
        ];

        activation.ida-pro-mcp = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          ${pkgs.ida-pro-mcp}/bin/ida-pro-mcp --install 2>/dev/null || true
        '';
      };
    };
}
