{
  flake.nixosModules.steam =
    { pkgs, ... }:
    {
      programs = {
        steam = {
          enable = true;
          extraCompatPackages = [ pkgs.proton-ge-bin ];
        };
        gamemode.enable = true;
      };
    };
}
