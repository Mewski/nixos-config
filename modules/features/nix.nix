{ inputs, ... }:
{
  flake.nixosModules.nix =
    { pkgs, ... }:
    {
      imports = [
        inputs.nix-index-database.nixosModules.nix-index
      ];

      nix = {
        package = pkgs.lix;

        settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
      };

      nixpkgs.config.allowUnfree = true;

      programs.nix-ld.enable = true;

      environment.systemPackages = with pkgs; [
        alejandra
        manix
        nil
        nix-inspect
        nixd
        statix
      ];
    };
}
