{ inputs, ... }:
{
  flake.nixosModules.astraeus = {
    imports = [ inputs.proxmox-nixos.nixosModules.proxmox-ve ];

    nixpkgs.overlays = [ inputs.proxmox-nixos.overlays.x86_64-linux ];

    boot.kernel.sysctl = {
      "net.bridge.bridge-nf-call-iptables" = 0;
      "net.bridge.bridge-nf-call-ip6tables" = 0;
    };

    networking = {
      vlans.vlan30 = {
        id = 30;
        interface = "ens1f0";
      };

      bridges.vmbr0.interfaces = [ "vlan30" ];
    };

    networking.firewall.allowedTCPPorts = [ 8006 ];

    services.proxmox-ve = {
      enable = true;
      ipAddress = "10.0.20.10";
      bridges = [ "vmbr0" ];
    };
  };
}
