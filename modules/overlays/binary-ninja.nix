{ inputs, ... }:
{
  perSystem =
    { system, pkgs, ... }:
    {
      overlayAttrs.binary-ninja-personal-wayland =
        inputs.binary-ninja.packages.${system}.binary-ninja-personal-wayland.overrideAttrs
          (old: {
            version = "5.3.9434";

            src = pkgs.requireFile {
              name = "binaryninja_linux_stable_personal.zip";
              url = "https://binary.ninja/recover/";
              sha256 = "7cf3e8b871023f735855ce90179fef02c5738faaf32c8d5ae1f8e901599aff7c";
            };

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
