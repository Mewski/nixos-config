{ inputs, ... }:
{
  flake.nixosModules.sops = {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    persist.files = [
      "/etc/sops/age/keys.txt"
    ];
  };
}
