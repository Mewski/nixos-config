{
  flake.homeModules.python =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.python3.withPackages (
          ps: with ps; [
            beautifulsoup4
            cryptography
            flask
            httpx
            impacket
            jsonschema
            keystone-engine
            lief
            lxml
            numpy
            openai
            opencv4
            pandas
            paramiko
            pefile
            pillow
            arrow
            capstone
            networkx
            pip
            protobuf
            pwntools
            pycryptodome
            pyyaml
            pygments
            ropgadget
            ropper
            scapy
            setuptools
            six
            requests
            sympy
            tiktoken
            tqdm
            unicorn
            uvicorn
            yara-python
            z3-solver
          ]
        ))
      ];
    };
}
