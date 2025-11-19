{ inputs, ... }:
{
  flake.nixosModules.sops = {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    persist.files = [
      ".config/sops/age/keys.txt"
    ];
  };
}
