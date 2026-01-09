{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      overlayAttrs.binary-ninja-personal-wayland =
        inputs.binary-ninja.packages.${system}.binary-ninja-personal-wayland.overrideAttrs
          (old: {
            postInstall = (old.postInstall or "") + ''
              cat >> $out/opt/binaryninja/python/binaryninja/_binaryninjacore.py << 'EOF'


              # Enable headless mode with UI features
              BNInitUI = core.BNInitUI
              BNInitUI.argtypes = [ctypes.c_longlong]
              BNInitUI.restype = ctypes.c_longlong
              assert BNInitUI(BNInitUI(0)) == 1
              EOF
            '';
          });
    };
}
