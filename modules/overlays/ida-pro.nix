{ inputs, ... }:
{
  perSystem =
    { system, pkgs, ... }:
    {
      overlayAttrs.ida-pro-mcp = pkgs.python3Packages.buildPythonApplication {
        pname = "ida-pro-mcp";
        version = "1.4.0";
        src = pkgs.fetchFromGitHub {
          owner = "mrexodia";
          repo = "ida-pro-mcp";
          rev = "1.4.0";
          hash = "sha256-abH6i/Xr3P3/gP8L151FZBU9ovp/olFWwKenPz7BuF8=";
        };
        pyproject = true;
        build-system = [ pkgs.python3Packages.setuptools ];
        dependencies = [ pkgs.python3Packages.mcp ];
      };

      overlayAttrs.ida-pro-wayland =
        inputs.ida-pro.packages.${system}.ida-pro-wayland.overrideAttrs
          (old: {
            nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.tinyxxd ];
            postFixup = (old.postFixup or "") + ''
              for lib in $out/opt/ida-pro/libida.so $out/opt/ida-pro/libida32.so; do
                if [ -f "$lib" ]; then
                  xxd -p "$lib" | tr -d '\n' \
                    | sed 's/edfd425cf978/edfd42cbf978/g' \
                    | sed 's/ff90f800000085c00f858d000000/ff90f800000085c0909090909090/g' \
                    | xxd -r -p > "$lib.patched"
                  mv "$lib.patched" "$lib"
                  chmod +x "$lib"
                fi
              done
            '';
          });
      overlayAttrs.bindiff = pkgs.stdenv.mkDerivation {
        pname = "bindiff";
        version = "8";
        src = pkgs.fetchurl {
          url = "https://github.com/google/bindiff/releases/download/v8/bindiff_8_amd64.deb";
          hash = "sha256-ghmQ45dKnfZzN5Q3DkhUhqwna6XXd6BrTr5XXwkvTdo=";
        };
        nativeBuildInputs = [
          pkgs.dpkg
          pkgs.autoPatchelfHook
        ];
        autoPatchelfIgnoreMissingDeps = [ "libbinaryninjacore.so.1" ];
        buildInputs = [
          pkgs.stdenv.cc.cc.lib
          pkgs.zlib
          pkgs.libx11
          pkgs.libxext
          pkgs.libxi
          pkgs.libxrender
          pkgs.libxtst
          pkgs.alsa-lib
        ];
        unpackPhase = ''
          dpkg-deb -x $src .
        '';
        installPhase = ''
          mkdir -p $out
          cp -r opt/bindiff/* $out/
        '';
      };

      overlayAttrs.bindiff-ida-plugins = pkgs.stdenv.mkDerivation {
        pname = "bindiff-ida-plugins";
        version = "9.3-20260302";
        srcs = [
          (pkgs.fetchurl {
            url = "https://github.com/Lil-Ran/build-bindiff-for-ida-9/releases/download/release-20260302-1/BinDiff-IDA_9.3-x86_64-linux-built_on_ubuntu_24.04.zip";
            hash = "sha256-iF3ZKsRqqSzLgx2+tsZ9SCi/LOqc6yV4Vt+2QWTgMGk=";
          })
          (pkgs.fetchurl {
            url = "https://github.com/Lil-Ran/build-bindiff-for-ida-9/releases/download/release-20260302-1/BinExport-IDA_9.3-x86_64-linux-built_on_ubuntu_24.04.zip";
            hash = "sha256-zYiEh/LHJlkYIE4PXMQoYkyHtfQFEdNSMKB1Ex6HZSE=";
          })
        ];
        nativeBuildInputs = [
          pkgs.unzip
          pkgs.autoPatchelfHook
        ];
        autoPatchelfIgnoreMissingDeps = [ "libida.so" ];
        buildInputs = [
          pkgs.stdenv.cc.cc.lib
        ];
        sourceRoot = ".";
        installPhase = ''
          mkdir -p $out
          cp ida/bindiff8_ida64.so $out/
          cp ida/binexport12_ida64.so $out/
        '';
      };
    };
}
