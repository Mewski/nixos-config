{ inputs, ... }:
{
  flake.homeModules.meridian =
    { pkgs, ... }:
    {
      imports = [ inputs.meridian.homeManagerModules.default ];

      services.meridian = {
        enable = true;
        package = inputs.meridian.packages.${pkgs.system}.default.overrideAttrs (old: {
          postInstall = (old.postInstall or "") + ''
            for js in $out/lib/meridian/dist/cli-*.js; do
              substituteInPlace "$js" \
                --replace-quiet 'var PASSTHROUGH_MCP_NAME = "oc";' 'var PASSTHROUGH_MCP_NAME = "builtin";' \
                --replace-quiet 'var MCP_SERVER_NAME = "opencode";' 'var MCP_SERVER_NAME = "builtin";'
            done
            grep -r 'PASSTHROUGH_MCP_NAME = "builtin"' $out/lib/meridian/dist/ >/dev/null
            grep -r 'MCP_SERVER_NAME = "builtin"' $out/lib/meridian/dist/ >/dev/null
          '';
        });
      };
    };
}
