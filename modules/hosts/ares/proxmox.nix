{ inputs, ... }:
{
  flake.nixosModules.ares = {
    imports = [ inputs.proxmox-nixos.nixosModules.proxmox-ve ];

    nixpkgs.overlays = [ inputs.proxmox-nixos.overlays.x86_64-linux ];

    boot.kernel.sysctl = {
      "net.bridge.bridge-nf-call-iptables" = 0;
      "net.bridge.bridge-nf-call-ip6tables" = 0;
    };

    networking.bridges = {
      vmbr0.interfaces = [ "ens1f0" ];
      vmbr1.interfaces = [ ];
      vmbr2.interfaces = [ ];
    };

    networking.firewall.allowedTCPPorts = [ 8006 ];

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
