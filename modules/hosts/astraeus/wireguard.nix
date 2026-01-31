{
  flake.nixosModules.astraeus =
    { config, ... }:
    {
      networking.wireguard.interfaces.wg-aeolus = {
        privateKeyFile = config.sops.secrets."wireguard/private_key".path;
        allowedIPsAsRoutes = false;

        ips = [
          "23.152.236.2/32"
          "2602:fe18::2/128"
        ];

        postSetup = ''
          ip rule add to 10.0.0.0/8 lookup main priority 100
          ip rule add to 192.168.0.0/16 lookup main priority 100
          ip rule add to 144.202.48.125 lookup main priority 100
          ip rule add from 23.152.236.0/28 lookup 100 priority 200
          ip rule add lookup 100 priority 300
          ip route add default dev wg-aeolus src 23.152.236.2 table 100

          ip -6 rule add to fd00::/8 lookup main priority 100
          ip -6 rule add from 2602:fe18::/60 lookup 100 priority 200
          ip -6 rule add lookup 100 priority 300
          ip -6 route add default dev wg-aeolus src 2602:fe18::2 table 100
        '';

        postShutdown = ''
          ip rule del to 10.0.0.0/8 lookup main priority 100 || true
          ip rule del to 192.168.0.0/16 lookup main priority 100 || true
          ip rule del to 144.202.48.125 lookup main priority 100 || true
          ip rule del from 23.152.236.0/28 lookup 100 priority 200 || true
          ip rule del lookup 100 priority 300 || true
          ip route del default dev wg-aeolus src 23.152.236.2 table 100 || true

          ip -6 rule del to fd00::/8 lookup main priority 100 || true
          ip -6 rule del from 2602:fe18::/60 lookup 100 priority 200 || true
          ip -6 rule del lookup 100 priority 300 || true
          ip -6 route del default dev wg-aeolus src 2602:fe18::2 table 100 || true
        '';

        peers = [
          {
            publicKey = "Ez3Fx1SmQHoPEuGasq235KNMPr3TqK6CCPE+VTnwUCk=";
            presharedKeyFile = config.sops.secrets."wireguard/aeolus/preshared_key".path;
            endpoint = "144.202.48.125:51820";
            persistentKeepalive = 25;
            allowedIPs = [
              "0.0.0.0/0"
              "::/0"
            ];
          }
        ];
      };
    };
}
