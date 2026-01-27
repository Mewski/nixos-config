{ inputs, self, ... }:
{
  flake.nixosConfigurations.prometheus = inputs.nixpkgs-stable.lib.nixosSystem {
    modules = [ self.nixosModules.prometheus ];
  };

  flake.nixosModules.prometheus = { };
}
