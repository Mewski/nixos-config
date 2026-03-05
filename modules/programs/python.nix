{
  flake.homeModules.python =
    { pkgs, ... }:
    # let
    #   python3 = pkgs.python3.override {
    #     packageOverrides = _pyfinal: pyprev: {
    #       angr = pyprev.angr.overridePythonAttrs (old: {
    #         version = "9.2.154";
    #         src = pkgs.fetchFromGitHub {
    #           owner = "angr";
    #           repo = "angr";
    #           tag = "v9.2.154";
    #           hash = "sha256-aOgZXHk6GTWZAEraZQahEXUYs8LWAWv1n9GfX+2XTPU=";
    #         };
    #         pythonImportsCheck = [ ];
    #         doCheck = false;
    #       });
    #       ailment = pyprev.ailment.overridePythonAttrs {
    #         version = "9.2.154";
    #         src = pkgs.fetchFromGitHub {
    #           owner = "angr";
    #           repo = "ailment";
    #           tag = "v9.2.154";
    #           hash = "sha256-JjS+jYWrbErkb6uM0DtB5h2ht6ZMmiYOQL/Emm6wC5U=";
    #         };
    #       };
    #       claripy = pyprev.claripy.overridePythonAttrs {
    #         version = "9.2.154";
    #         src = pkgs.fetchFromGitHub {
    #           owner = "angr";
    #           repo = "claripy";
    #           tag = "v9.2.154";
    #           hash = "sha256-90JX+VDWK/yKhuX6D8hbLxjIOS8vGKrN1PKR8iWjt2o=";
    #         };
    #       };
    #     };
    #   };
    # in
    {
      home.packages = [
        (pkgs.python3.withPackages (
          ps: with ps; [
            # angr
            beautifulsoup4
            capstone
            cryptography
            evtx
            fickling
            flask
            gmpy2
            impacket
            keystone-engine
            lxml
            numpy
            opencv4
            paramiko
            pefile
            pillow
            pip
            pycryptodome
            pwntools
            requests
            ropgadget
            ropper
            scapy
            sympy
            tqdm
            unicorn
            uvicorn
            z3-solver
          ]
        ))
      ];
    };
}
