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

    networking = {
      bridges.vmbr1.interfaces = [ ];

      interfaces.vmbr1 = {
        ipv4.addresses = [
          {
            address = "23.152.236.2";
            prefixLength = 28;
          }
        ];
        ipv6.addresses = [
          {
            address = "2602:fe18::2";
            prefixLength = 60;
          }
        ];
      };
    };
  };
}
