{ inputs, self, ... }:
{
  flake.nixosModules.aeolus = {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    sops = {
      defaultSopsFile = "${self}/secrets/aeolus/secrets.yaml";
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

      secrets = {
        "bird/vultr/bgp_password" = { };

        "wg0/private_key" = { };
        "wg0/astraeus/preshared_key" = { };
        "wg0/ares/preshared_key" = { };

        "wg1/private_key" = { };
        "wg1/mewski/preshared_key" = { };
      };
    };
  };
}
