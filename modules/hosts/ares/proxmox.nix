{ inputs, ... }:
{
  flake.nixosModules.ares = {
    imports = [ inputs.proxmox-nixos.nixosModules.proxmox-ve ];

    nixpkgs.overlays = [ inputs.proxmox-nixos.overlays.x86_64-linux ];

    networking.bridges = {
      vmbr0.interfaces = [ "ens1f0" ];
      vmbr1.interfaces = [ ];
      vmbr2.interfaces = [ ];
    };

    services.proxmox-ve = {
      enable = true;
      ipAddress = "10.0.50.10";
      bridges = [
        "vmbr0"
        "vmbr1"
        "vmbr2"
      ];
    };
  };
}
