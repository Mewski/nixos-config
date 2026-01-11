{ self, ... }:
{
  flake.nixosModules.gaming = {
    imports = [
      self.nixosModules.flatpak
      self.nixosModules.sober
      self.nixosModules.steam
    ];
  };

  flake.homeModules.gaming = {
    imports = [
      self.homeModules.osu
      self.homeModules.prism-launcher
    ];
  };
}
