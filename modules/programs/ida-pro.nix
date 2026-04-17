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
      lazyida = pkgs.fetchFromGitHub {
        owner = "L4ys";
        repo = "LazyIDA";
        rev = "0ecdf8d62554405fecdd000c750644499f4eccc0";
        hash = "sha256-kTeMY2+GyzYnzf22iSV2KXJ3eMocEQB0cWgFzWESsV4=";
      };
      hashdb = pkgs.fetchFromGitHub {
        owner = "OALabs";
        repo = "hashdb-ida";
        rev = "deddbdee829a3c5fb93086481f78b7494defe020";
        hash = "sha256-UnwVXHNxeC/oO+jotm8vtt0G2VtG9dG3n8xvdFi7H1w=";
      };
      findcrypt-yara = pkgs.fetchFromGitHub {
        owner = "polymorf";
        repo = "findcrypt-yara";
        rev = "044644b9c52ae3e7b2305bac15b0c12c9e31a282";
        hash = "sha256-PTwWyX+INyRiGITb7t8Ljn9tvDvG9zNli+chFn/F4Og=";
      };
      keypatch = pkgs.fetchFromGitHub {
        owner = "keystone-engine";
        repo = "keypatch";
        rev = "e7ecb93a4d242e83b9356b8258108773464646d4";
        hash = "sha256-MTOMYH0y70B6NeLmdEJucYuvmo/V4bRXTd7iaTbo/IQ=";
      };
      patching = pkgs.stdenv.mkDerivation {
        pname = "ida-patching";
        version = "0.2.0";
        src = pkgs.fetchurl {
          url = "https://github.com/gaasedelen/patching/releases/download/v0.2.0/patching_linux.zip";
          hash = "sha256-csTvwh11h62LrgzOu+zI6v/qaQ4HQqLnF9doy6IQhrk=";
        };
        nativeBuildInputs = [
          pkgs.unzip
          pkgs.autoPatchelfHook
        ];
        buildInputs = [ pkgs.stdenv.cc.cc.lib ];
        sourceRoot = ".";
        installPhase = ''
          mkdir -p $out/patching
          cp patching.py $out/
          cp -r patching/* $out/patching/
        '';
      };
      ret-sync = pkgs.fetchFromGitHub {
        owner = "bootleg";
        repo = "ret-sync";
        rev = "60e7b0fd1bea7bad44da7688801b2bd12fb02040";
        hash = "sha256-pHj9B3X/2ZnQIalZ5yf+MoDZ0jph9/XUStuE28tvjOY=";
      };
      gepetto = pkgs.fetchFromGitHub {
        owner = "JusticeRage";
        repo = "Gepetto";
        rev = "080a2bbfa80a7ea99a93ce872d911b5af655fc77";
        hash = "sha256-G8Szxu2NYXoTJi+2ZeMzol2wgRCrFjrojxMY7ax585Y=";
      };
      lighthouse = pkgs.fetchFromGitHub {
        owner = "gaasedelen";
        repo = "lighthouse";
        rev = "562595be9bd99e8a5dfef6017d608467f5706630";
        hash = "sha256-H2yVP4RlqBH65VlsAZBME3FTebEHbSfk/ZIj+qB3fLo=";
      };
      d810-ng = pkgs.fetchFromGitHub {
        owner = "w00tzenheimer";
        repo = "d810-ng";
        rev = "6f716c765fb1b11e60d2b29ed5266d7c17d41731";
        hash = "sha256-9YOlnPTgCCpdENNizbHs1xQ9TuskFr2Srz6NvEj3QsA=";
      };
      flare-ida = pkgs.fetchFromGitHub {
        owner = "mandiant";
        repo = "flare-ida";
        rev = "fc667de6db279c6f8ec8bcc2f3eedff348db450f";
        hash = "sha256-tNo8hjM0k4Y7Cip5GF0G6pXXzcnAOM2oUL/j/81zdZk=";
      };
      efixplorer = pkgs.stdenv.mkDerivation {
        pname = "efiXplorer";
        version = "6.2.0";
        src = pkgs.fetchurl {
          url = "https://github.com/REhints/efiXplorer/releases/download/v6.2.0/efiXplorer-v6.2.0.zip";
          hash = "sha256-GLOpGYQJGtBaeyn4/M22KyQri9rbh7tUqxzQOIEE77s=";
        };
        nativeBuildInputs = [
          pkgs.unzip
          pkgs.autoPatchelfHook
        ];
        autoPatchelfIgnoreMissingDeps = [ "libida.so" ];
        buildInputs = [ pkgs.stdenv.cc.cc.lib ];
        sourceRoot = ".";
        installPhase = ''
          mkdir -p $out/plugins $out/loaders $out/guids
          cp efiXplorer-v6.2.0/efiXplorer.so $out/plugins/
          cp efiXplorer-v6.2.0/guids/guids.json $out/guids/
          cp efiXplorer-v6.2.0/loader/efiXloader.so $out/loaders/
        '';
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
        file.".idapro/plugins/wakatime.py".source = "${ida-wakatime}/wakatime.py";

        file.".idapro/plugins/diaphora_plugin.py".source = "${diaphora}/plugin/diaphora_plugin.py";
        file.".idapro/plugins/diaphora_plugin.cfg".source = diaphora-cfg;

        file.".idapro/plugins/bindiff8_ida64.so".source = "${pkgs.bindiff-ida-plugins}/bindiff8_ida64.so";
        file.".idapro/plugins/binexport12_ida64.so".source =
          "${pkgs.bindiff-ida-plugins}/binexport12_ida64.so";

        file.".idapro/plugins/LazyIDA.py".source = "${lazyida}/LazyIDA.py";

        file.".idapro/plugins/hashdb.py".source = "${hashdb}/hashdb.py";

        file.".idapro/plugins/findcrypt3.py".source = "${findcrypt-yara}/findcrypt3.py";
        file.".idapro/plugins/findcrypt3.rules".source = "${findcrypt-yara}/findcrypt3.rules";

        file.".idapro/plugins/keypatch.py".source = "${keypatch}/keypatch.py";

        file.".idapro/plugins/patching.py".source = "${patching}/patching.py";
        file.".idapro/plugins/patching".source = "${patching}/patching";

        file.".idapro/plugins/SyncPlugin.py".source = "${ret-sync}/ext_ida/SyncPlugin.py";
        file.".idapro/plugins/retsync".source = "${ret-sync}/ext_ida/retsync";

        file.".idapro/plugins/gepetto.py".source = "${gepetto}/gepetto.py";
        file.".idapro/plugins/gepetto".source = "${gepetto}/gepetto";

        file.".idapro/plugins/lighthouse_plugin.py".source = "${lighthouse}/plugins/lighthouse_plugin.py";
        file.".idapro/plugins/lighthouse".source = "${lighthouse}/plugins/lighthouse";

        file.".idapro/plugins/d810ng.py".source = "${d810-ng}/src/d810ng.py";
        file.".idapro/plugins/d810".source = "${d810-ng}/src/d810";

        file.".idapro/plugins/apply_callee_type_plugin.py".source =
          "${flare-ida}/plugins/apply_callee_type_plugin.py";
        file.".idapro/plugins/shellcode_hashes_search_plugin.py".source =
          "${flare-ida}/plugins/shellcode_hashes_search_plugin.py";
        file.".idapro/plugins/stackstrings_plugin.py".source =
          "${flare-ida}/plugins/stackstrings_plugin.py";
        file.".idapro/plugins/struct_typer_plugin.py".source =
          "${flare-ida}/plugins/struct_typer_plugin.py";
        file.".idapro/python/flare".source = "${flare-ida}/python/flare";

        file.".idapro/plugins/efiXplorer.so".source = "${efixplorer}/plugins/efiXplorer.so";
        file.".idapro/plugins/guids".source = "${efixplorer}/guids";
        file.".idapro/loaders/efiXloader.so".source = "${efixplorer}/loaders/efiXloader.so";

        activation.ida-pro-mcp = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          ${pkgs.ida-pro-mcp}/bin/ida-pro-mcp --install 2>/dev/null || true
        '';
      };
    };
}
