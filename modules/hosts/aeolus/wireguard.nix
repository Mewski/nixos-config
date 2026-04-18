{
  flake.nixosModules.aeolus =
    { config, ... }:
    {
      networking = {
        firewall.allowedUDPPorts = [ 51820 ];

        wg-quick.interfaces.wg0 = {
          address = [ "23.152.236.16/32" ];
          listenPort = 51820;
          privateKeyFile = config.sops.secrets."wg0/private_key".path;
          mtu = 1420;

          postUp = ''
            iptables -A FORWARD -i wg0 -j ACCEPT
            iptables -A FORWARD -o wg0 -j ACCEPT
            iptables -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -o wg0 -j TCPMSS --clamp-mss-to-pmtu
            iptables -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -i wg0 -j TCPMSS --clamp-mss-to-pmtu
            ip6tables -A FORWARD -i wg0 -j ACCEPT
            ip6tables -A FORWARD -o wg0 -j ACCEPT
            ip6tables -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -o wg0 -j TCPMSS --clamp-mss-to-pmtu
            ip6tables -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -i wg0 -j TCPMSS --clamp-mss-to-pmtu
          '';

          postDown = ''
            iptables -D FORWARD -i wg0 -j ACCEPT
            iptables -D FORWARD -o wg0 -j ACCEPT
            iptables -t mangle -D FORWARD -p tcp --tcp-flags SYN,RST SYN -o wg0 -j TCPMSS --clamp-mss-to-pmtu
            iptables -t mangle -D FORWARD -p tcp --tcp-flags SYN,RST SYN -i wg0 -j TCPMSS --clamp-mss-to-pmtu
            ip6tables -D FORWARD -i wg0 -j ACCEPT
            ip6tables -D FORWARD -o wg0 -j ACCEPT
            ip6tables -t mangle -D FORWARD -p tcp --tcp-flags SYN,RST SYN -o wg0 -j TCPMSS --clamp-mss-to-pmtu
            ip6tables -t mangle -D FORWARD -p tcp --tcp-flags SYN,RST SYN -i wg0 -j TCPMSS --clamp-mss-to-pmtu
          '';

          peers = [
            {
              publicKey = "qR2zwNchwzIeoYe3tCDkA/1C4c8DI1RFhvGJRFBRKmw=";
              presharedKeyFile = config.sops.secrets."wg0/udm/preshared_key".path;
              allowedIPs = [
                "23.152.236.17/32"
                "23.152.236.64/28"
              ];
            }
          ];
        };
      };

      systemd.services."wg-quick-wg0" = {
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
        serviceConfig = {
          Restart = "on-failure";
          RestartSec = 5;
        };
      };
    };
}
