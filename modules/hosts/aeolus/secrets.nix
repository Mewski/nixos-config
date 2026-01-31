{ inputs, self, ... }:
{
  flake.nixosModules.aeolus = {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    sops = {
      defaultSopsFile = "${self}/secrets/aeolus/secrets.yaml";
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

      secrets = {
        "bird/vultr/bgp_password" = { };

        "wireguard/private_key" = { };
        "wireguard/astraeus/preshared_key" = { };
      };
    };
  };
}
