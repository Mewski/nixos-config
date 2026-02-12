{
  flake.homeModules.python =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.python3.withPackages (
          ps: with ps; [
            angr
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
