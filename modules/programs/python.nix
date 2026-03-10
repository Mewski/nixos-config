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
            lxml
            numpy
            opencv4
            paramiko
            pillow
            pip
            requests
            sympy
            tqdm
            uvicorn
          ]
        ))
      ];
    };
}
