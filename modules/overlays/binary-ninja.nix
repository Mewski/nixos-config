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
              import threading

              BNInitUI = core.BNInitUI
              BNInitUI.argtypes = [ctypes.c_longlong]
              BNInitUI.restype = ctypes.c_longlong

              def init_ui():
              	assert BNInitUI(BNInitUI(0)) == 1

              ui_thread = threading.Thread(target=init_ui)
              ui_thread.start()
              ui_thread.join()
              EOF
            '';
          });
    };
}
