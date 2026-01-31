{ inputs, ... }:
{
  flake.nixosModules.astraeus = {
    imports = [ inputs.proxmox-nixos.nixosModules.proxmox-ve ];

    nixpkgs.overlays = [ inputs.proxmox-nixos.overlays.x86_64-linux ];

    services.proxmox-ve = {
      enable = true;
      ipAddress = "10.0.20.10";
      bridges = [
        "vmbr0"
        "vmbr1"
        "vmbr2"
      ];
    };

    networking.vlans = {
      vlan30 = {
        id = 30;
        interface = "ens1f0";
      };
      vlan40 = {
        id = 40;
        interface = "ens1f0";
      };
    };

    networking.bridges = {
      vmbr0.interfaces = [ "vlan30" ];
      vmbr1.interfaces = [ "vlan40" ];
      vmbr2.interfaces = [ ];
    };

    boot.kernel.sysctl = {
      "net.bridge.bridge-nf-call-iptables" = 1;
      "net.bridge.bridge-nf-call-ip6tables" = 1;
    };

    networking.firewall.extraCommands = ''
      iptables -I FORWARD -i vmbr2 -o vmbr2 -j DROP
      iptables -I FORWARD -i vmbr2 -d 10.0.0.0/8 -j DROP
      iptables -I FORWARD -i vmbr2 -d 192.168.0.0/16 -j DROP
      iptables -I INPUT -i vmbr2 -j DROP

      ip6tables -I FORWARD -i vmbr2 -o vmbr2 -j DROP
      ip6tables -I FORWARD -i vmbr2 -d fc00::/7 -j DROP
      ip6tables -I INPUT -i vmbr2 -j DROP
    '';

    networking.firewall.extraStopCommands = ''
      iptables -D FORWARD -i vmbr2 -o vmbr2 -j DROP || true
      iptables -D FORWARD -i vmbr2 -d 10.0.0.0/8 -j DROP || true
      iptables -D FORWARD -i vmbr2 -d 192.168.0.0/16 -j DROP || true
      iptables -D INPUT -i vmbr2 -j DROP || true

      ip6tables -D FORWARD -i vmbr2 -o vmbr2 -j DROP || true
      ip6tables -D FORWARD -i vmbr2 -d fc00::/7 -j DROP || true
      ip6tables -D INPUT -i vmbr2 -j DROP || true
    '';
  };
}
