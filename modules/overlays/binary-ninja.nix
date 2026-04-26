{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      overlayAttrs.binary-ninja-personal-wayland =
        inputs.binary-ninja.packages.${system}.binary-ninja-personal-wayland.overrideAttrs
          (old: {
            version = "5.3.9434";

            src = "${inputs.installers}/binaryninja_linux_stable_personal.zip";

            postFixup = (old.postFixup or "") + ''
              rm $out/bin/binaryninja
              makeWrapper $out/opt/binaryninja/binaryninja $out/bin/binaryninja \
                --prefix PYTHONPATH : "$program_PYTHONPATH" \
                --set QT_QPA_PLATFORM wayland \
                --set QT_PLUGIN_PATH "$out/opt/binaryninja/qt" \
                --unset QT_STYLE_OVERRIDE
            '';

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
