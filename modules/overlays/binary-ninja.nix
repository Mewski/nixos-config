{ inputs, ... }:
{
  perSystem =
    { system, pkgs, ... }:
    {
      overlayAttrs.binary-ninja-personal-wayland =
        inputs.binary-ninja.packages.${system}.binary-ninja-personal-wayland.overrideAttrs
          (old: {
            version = "dev";

            src = pkgs.requireFile {
              name = "binaryninja_linux_dev_personal.zip";
              url = "https://binary.ninja/recover/";
              sha256 = "7afd705f5cd65da4bf0c5f0bc6c073717f873b268d23bd0fbf2797a21f7d4a81";
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
