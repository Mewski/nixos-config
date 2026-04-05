{ inputs, ... }:
{
  perSystem =
    { system, pkgs, ... }:
    {
      overlayAttrs.ida-pro-wayland =
        inputs.ida-pro.packages.${system}.ida-pro-wayland.overrideAttrs
          (old: {
            nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.tinyxxd ];
            postFixup = (old.postFixup or "") + ''
              for lib in $out/opt/ida-pro/libida.so $out/opt/ida-pro/libida32.so; do
                if [ -f "$lib" ]; then
                  xxd -p "$lib" | tr -d '\n' \
                    | sed 's/edfd425cf978/edfd42cbf978/g' \
                    | xxd -r -p > "$lib.patched"
                  mv "$lib.patched" "$lib"
                  chmod +x "$lib"
                fi
              done
            '';
          });
    };
}
