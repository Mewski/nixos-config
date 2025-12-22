{ inputs, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.easyOverlay ];

  perSystem =
    { pkgs, ... }:
    let
      spotx = pkgs.fetchurl {
        url = "https://github.com/SpotX-Official/SpotX-Bash/raw/08efd4cd2e66e3403be9cb61b9e1f4c56f404c2f/spotx.sh";
        hash = "sha256-u0StJeTaPhRsVdoC1VnRTaBA1mffyc3/CATF2N3sq6g=";
      };
    in
    {
      overlayAttrs = {
        spotify = pkgs.spotify.overrideAttrs (old: {
          nativeBuildInputs = old.nativeBuildInputs ++ [
            pkgs.util-linux
            pkgs.perl
            pkgs.unzip
            pkgs.zip
            pkgs.curl
          ];

          postUnpack = ''
            patchShebangs --build ${spotx}
          '';

          postInstall = (old.postInstall or "") + ''
            bash ${spotx} -f -P "$out/share/spotify"
          '';
        });
      };
    };
}
