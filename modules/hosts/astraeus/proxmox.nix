{ inputs, ... }:
{
  flake.nixosModules.astraeus = {
    imports = [ inputs.proxmox-nixos.nixosModules.proxmox-ve ];

    nixpkgs.overlays = [
      inputs.proxmox-nixos.overlays.x86_64-linux
    ];

    services.proxmox-ve = {
      enable = true;
      ipAddress = "10.0.20.10";
    };

    networking.bridges.vmbr1.interfaces = [ ];
  };
}
