{
  flake.homeModules.ida-pro =
    { lib, pkgs, ... }:
    let
      vulfi = pkgs.fetchFromGitHub {
        owner = "Accenture";
        repo = "VulFi";
        rev = "0bb7fdf8ccb906600cc209c35daf05774172acc8";
        hash = "sha256-P2bfFe3LgwtGxajaG7MPcCHCIg9P1YyaRMogR9KBkBU=";
      };
    in
    {
      home = {
        packages = [
          pkgs.ida-pro-wayland
          pkgs.ida-pro-mcp
        ];

        file.".idapro/plugins/vulfi.py".source = "${vulfi}/vulfi.py";
        file.".idapro/plugins/vulfi_prototypes.json".source = "${vulfi}/vulfi_prototypes.json";

        activation.ida-pro-mcp = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          ${pkgs.ida-pro-mcp}/bin/ida-pro-mcp --install 2>/dev/null || true
        '';
      };
    };
}
