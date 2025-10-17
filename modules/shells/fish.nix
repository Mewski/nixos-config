{
  flake.nixosModules.fish = {
    programs.fish.enable = true;
  };

  flake.homeModules.fish = {
    programs.fish.enable = true;
  };
}
