{
  flake.nixosModules.steam = {
    programs = {
      steam.enable = true;
      gamemode.enable = true;
    };
  };
}
