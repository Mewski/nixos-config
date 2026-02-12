{
  flake.homeModules.python =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.python3.withPackages (
          ps: with ps; [
            numpy
            pip
            requests
            angr
            evtx
            fickling
            impacket
            lxml
            opencv4
            pillow
            pycryptodome
            pwntools
            tqdm
            uvicorn
            z3-solver
          ]
        ))
      ];
    };
}
