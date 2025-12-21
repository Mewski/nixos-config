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

      nixpkgs.config.allowUnfree = true;

      nixpkgs.overlays = [ inputs.self.overlays.default ];

      programs.nix-index-database.comma.enable = true;

      programs.nix-ld.enable = true;

      environment.systemPackages = with pkgs; [
        alejandra
        statix

        nil
        nixd
      ];
    };
}
