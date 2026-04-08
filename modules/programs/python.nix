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
            paramiko
            pillow
            arrow
            capstone
            networkx
            pip
            pygments
            setuptools
            six
            requests
            sympy
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
