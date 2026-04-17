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
      ida-wakatime = pkgs.fetchFromGitHub {
        owner = "es3n1n";
        repo = "ida-wakatime-py";
        rev = "68a13d1fbf13f901c735b266715ac5e467517270";
        hash = "sha256-a4prB6UURs2O187TlPB5wLwa4pxvnNoLB2u+aI5Y8Bw=";
      };
      diaphora = pkgs.fetchFromGitHub {
        owner = "joxeankoret";
        repo = "diaphora";
        rev = "d8b898e35750d103cb6a15f7a87910ff6b237427";
        hash = "sha256-Ee5HP6xaPu9HyFs4gmnZuKjdD3RpsRFm8oCfm20qlWw=";
      };
      diaphora-cfg = pkgs.writeText "diaphora_plugin.cfg" ''
        [Diaphora]
        path=${diaphora}
      '';
    in
    {
      home = {
        packages = [
          pkgs.ida-pro-wayland
          pkgs.ida-pro-mcp
        ];

        file.".idapro/plugins/vulfi.py".source = "${vulfi}/vulfi.py";
        file.".idapro/plugins/vulfi_prototypes.json".source = "${vulfi}/vulfi_prototypes.json";
        file.".idapro/plugins/wakatime.py".source = "${ida-wakatime}/wakatime.py";

        file.".idapro/plugins/diaphora_plugin.py".source = "${diaphora}/plugin/diaphora_plugin.py";
        file.".idapro/plugins/diaphora_plugin.cfg".source = diaphora-cfg;

        activation.ida-pro-mcp = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          ${pkgs.ida-pro-mcp}/bin/ida-pro-mcp --install 2>/dev/null || true
        '';
      };
    };
}
