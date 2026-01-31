{ inputs, self, ... }:
{
  flake.nixosModules.aeolus-disabled = {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    sops = {
      defaultSopsFile = "${self}/secrets/aeolus/secrets.yaml";
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

      secrets = {
        "bird/vultr/bgp_password" = { };
      };
    };
  };
}
