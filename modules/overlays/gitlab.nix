{ inputs, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.easyOverlay ];

  perSystem =
    { pkgs, ... }:
    let
      licenseKey = pkgs.writeText "license_encryption_key.pub" ''
        -----BEGIN PUBLIC KEY-----
        MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAreEfP/ncA1A5cuxBz7rS
        0Z9DDxdSymLwt2OUSM5WJa+dVB3zSpQjinifdNZq+iHVt8toZBZZ02H3unbn8td0
        rIifoj4oVpLhvnOAVjUn5tZeUX17tWMA+yyBpf6w6IFxeYBXFd14WOKEarS05U9B
        59DjBxNqSm+GzhljHO7vvTKy2xXQQ7Fa702DZ7jwr4DJnL87bDXfarnYksuawqtK
        wQbFHAOvxFj8ghBh1Gshap1abExD4l7QWxFMTCVOkLJmXiqfOi5KuMiaMsSUsCBN
        QDE3A5aKvpwLGozsvpGRMy5Tt4SgHC7ZbgerBNe75olOoPDxZf7bBt0+O5A/UjK/
        HwIDAQAB
        -----END PUBLIC KEY-----
      '';
    in
    {
      overlayAttrs = {
        gitlab-ee = pkgs.gitlab-ee.overrideAttrs (old: {
          postInstall = (old.postInstall or "") + ''
            cp ${licenseKey} $out/share/gitlab/.license_encryption_key.pub
          '';
        });
      };
    };
}
