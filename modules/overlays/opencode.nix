{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      overlayAttrs.opencode = inputs.opencode.packages.${system}.default.overrideAttrs (old: {
        prePatch = (old.prePatch or "") + ''
          substituteInPlace packages/opencode/script/build.ts \
            --replace-fail 'external: ["node-gyp"]' 'external: ["node-gyp", "prettier", "prettier/plugins/babel", "prettier/plugins/estree"]'
        '';
      });
    };
}
