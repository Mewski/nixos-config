{
  perSystem =
    { pkgs, ... }:
    {
      overlayAttrs.solaar = pkgs.solaar.overrideAttrs {
        version = "unstable-2026-05-14";
        src = pkgs.fetchFromGitHub {
          owner = "pwr-Solaar";
          repo = "Solaar";
          rev = "3e88c736455c2266675866d511936c15496dcc34";
          hash = "sha256-r0evTqaeD548HdFhVzvc7lDJgnxemwfXO0UiLNrPxw4=";
        };
      };
    };
}
