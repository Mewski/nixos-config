{ inputs, self, ... }:
{
  flake.nixosModules.ares = {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    sops = {
      defaultSopsFile = "${self}/secrets/ares/secrets.yaml";
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

      secrets = {
        "wg0/private_key" = { };
        "wg0/aeolus/preshared_key" = { };
      };
    };
  };
}
