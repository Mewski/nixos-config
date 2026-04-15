{ self, ... }:
{
  flake.nixosModules.server = {
    imports = [
      self.nixosModules.locale
      self.nixosModules.nix
    ];
  };
}
