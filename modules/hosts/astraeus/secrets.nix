{ inputs, self, ... }:
{
  flake.nixosModules.astraeus = {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    sops = {
      defaultSopsFile = "${self}/secrets/astraeus/secrets.yaml";
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

      secrets = {
        "wg0/private_key" = { };
        "wg0/aeolus/preshared_key" = { };
      };
    };
  };
}
