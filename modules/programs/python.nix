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
            jsonschema
            keystone-engine
            lief
            lxml
            numpy
            openai
            opencv4
            pandas
            paramiko
            pillow
            arrow
            capstone
            networkx
            pip
            protobuf
            pyyaml
            pygments
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
