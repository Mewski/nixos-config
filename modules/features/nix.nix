{ inputs, ... }:
{
  flake.nixosModules.nix =
    { pkgs, ... }:
    {
      imports = [ inputs.nix-index-database.nixosModules.nix-index ];

      nix = {
        package = pkgs.lix;
        settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
      };

      nixpkgs = {
        config.allowUnfree = true;
        overlays = [ inputs.self.overlays.default ];
      };

      programs = {
        nix-index-database.comma.enable = true;
        nix-ld.enable = true;
      };

      environment = {
        variables.NIXPKGS_ALLOW_UNFREE = "1";

        systemPackages = with pkgs; [
          nil
          nix-output-monitor
          nixd
          nixfmt
          statix
        ];
      };
    };
}
