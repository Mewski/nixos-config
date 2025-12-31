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

      environment.systemPackages = with pkgs; [
        nixfmt-rfc-style
        statix
        nil
        nixd
      ];
    };
}
