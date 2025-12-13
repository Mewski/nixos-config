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

        gc = {
          automatic = true;
          dates = "daily";
          options = "--delete-older-than 7d";
        };
      };

      nixpkgs.config.allowUnfree = true;

      programs.nix-index-database.comma.enable = true;

      programs.nix-ld.enable = true;

      environment.systemPackages = with pkgs; [
        alejandra
        nil
        nixd
        statix
      ];
    };
}
