{ inputs, ... }:
{
  flake.nixosModules.sops = {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    sops.defaultSopsFile = ../../sops-secrets/example.yaml;
    sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    persist.files = [
      ".config/sops/age/keys.txt"
    ];
  };
}
