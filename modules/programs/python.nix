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
            keystone-engine
            lxml
            numpy
            openai
            opencv4
            paramiko
            pillow
            pip
            setuptools
            requests
            sympy
            tqdm
            uvicorn
            yara-python
            z3-solver
          ]
        ))
      ];
    };
}
