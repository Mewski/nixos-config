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
          ipv4.addresses = [
            {
              address = "172.16.0.1";
              prefixLength = 30;
            }
          ];
          ipv6.addresses = [
            {
              address = "fd00::1";
              prefixLength = 126;
            }
          ];
        };

        localCommands = ''
          ${lib.getExe' pkgs.iproute2 "ip"} route replace 23.152.236.32/27 via 172.16.0.2
          ${lib.getExe' pkgs.iproute2 "ip"} -6 route replace 2602:fe18:1::/48 via fd00::2
        '';

        firewall.extraCommands = ''
          ${iptables} -I nixos-fw -p tcp --dport 8006 ! -i vmbr0 -j nixos-fw-refuse
          ${ip6tables} -I nixos-fw -p tcp --dport 8006 ! -i vmbr0 -j nixos-fw-refuse
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
