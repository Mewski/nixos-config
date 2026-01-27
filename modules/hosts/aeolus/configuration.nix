{ inputs, self, ... }:
{
  flake.nixosConfigurations.aeolus = inputs.nixpkgs-stable.lib.nixosSystem {
    modules = [ self.nixosModules.aeolus ];
  };

  flake.nixosModules.aeolus = { };
}
