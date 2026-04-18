{ inputs, self, ... }:
let
  deployNodes = [
    "astraeus"
    "aeolus"
    "prometheus"
  ];
in
{
  flake.deploy.nodes = builtins.listToAttrs (
    map (name: {
      inherit name;
      value = {
        hostname = "${name}.takoyaki.io";
        profiles.system = {
          user = "root";
          sshUser = "root";
          path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.${name};
        };
      };
    }) deployNodes
  );
}
