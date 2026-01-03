{
  perSystem =
    { pkgs, ... }:
    {
      overlayAttrs.discord = pkgs.discord.overrideAttrs (old: {
        postFixup = (old.postFixup or "") + ''
          wrapProgram $out/opt/Discord/Discord \
            --add-flags "--enable-gpu-rasterization"
        '';
      });
    };
}
