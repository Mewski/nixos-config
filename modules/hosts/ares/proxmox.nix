{ inputs, ... }:
{
  flake.nixosModules.ares =
    { pkgs, lib, ... }:
    let
      iptables = lib.getExe' pkgs.iptables "iptables";
      ip6tables = lib.getExe' pkgs.iptables "ip6tables";
    in
    {
      imports = [ inputs.proxmox-nixos.nixosModules.proxmox-ve ];

      nixpkgs.overlays = [ inputs.proxmox-nixos.overlays.x86_64-linux ];

      boot.kernel.sysctl = {
        "net.bridge.bridge-nf-call-iptables" = 0;
        "net.bridge.bridge-nf-call-ip6tables" = 0;
      };

      networking = {
        bridges = {
          vmbr0.interfaces = [ "ens1f0" ];
          vmbr1.interfaces = [ ];
          vmbr2.interfaces = [ ];
        };

        interfaces.vmbr1 = {
          mtu = 1420;
          ipv4.addresses = [
            {
              address = "23.152.236.16";
              prefixLength = 28;
            }
          ];
          ipv6.addresses = [
            {
              address = "2602:fe18:1::1";
              prefixLength = 64;
            }
          ];
          ipv6.routes = [
            {
              address = "2602:fe18:1:10::";
              prefixLength = 64;
              via = "2602:fe18:1::2";
            }
          ];
        };

        firewall.extraCommands = ''
          ${iptables} -A nixos-fw -i vmbr1 -p tcp --dport 8006 -j nixos-fw-accept
          ${ip6tables} -A nixos-fw -i vmbr1 -p tcp --dport 8006 -j nixos-fw-accept
          ${iptables} -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -o wg0 -j TCPMSS --clamp-mss-to-pmtu
          ${iptables} -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -i wg0 -j TCPMSS --clamp-mss-to-pmtu
          ${ip6tables} -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -o wg0 -j TCPMSS --clamp-mss-to-pmtu
          ${ip6tables} -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -i wg0 -j TCPMSS --clamp-mss-to-pmtu
        '';
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
