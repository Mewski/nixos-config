{ inputs, self, ... }:
{
  flake.deploy.nodes = {
    astraeus = {
      hostname = "astraeus.takoyaki.io";
      profiles.system = {
        user = "root";
        sshUser = "root";
        path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.astraeus;
      };
    };

    aeolus = {
      hostname = "aeolus.takoyaki.io";
      profiles.system = {
        user = "root";
        sshUser = "root";
        path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.aeolus;
      };
    };

    prometheus = {
      hostname = "prometheus.takoyaki.io";
      profiles.system = {
        user = "root";
        sshUser = "root";
        path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.prometheus;
      };
    };
  };

  flake.checks = builtins.mapAttrs (
    system: deployLib: deployLib.deployChecks self.deploy
  ) inputs.deploy-rs.lib;
}
