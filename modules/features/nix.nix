{
  flake.nixosModules.nix =
    { pkgs, ... }:
    {
      nix = {
        package = pkgs.lix;

        settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
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
