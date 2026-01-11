{ self, ... }:
{
  flake.nixosModules.gaming = {
    imports = [
      self.nixosModules.flatpak
      self.nixosModules.steam
      self.nixosModules.sober
    ];
  };

  flake.homeModules.gaming = {
    imports = [
      self.homeModules.osu
      self.homeModules.prism-launcher
    ];
  };
}
