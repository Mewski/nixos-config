{
  flake.nixosModules.astraeus = {
    nix.settings = {
      extra-substituters = [
        "https://nix-community.cachix.org"
        "https://cache.saumon.network/proxmox-nixos"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "proxmox-nixos:D9RYSWpQQC/msZUWphOY2I5RLH5Dd6yQcaHIuug7dWM="
      ];
    };
  };
}
