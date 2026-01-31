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
          ip rule add from 23.152.236.0/28 table 100
          ip route add default dev wg-aeolus table 100
          ip -6 rule add from 2602:fe18::/60 table 100
          ip -6 route add default dev wg-aeolus table 100
        '';

        postShutdown = ''
          ip rule del from 23.152.236.0/28 table 100 || true
          ip route del default dev wg-aeolus table 100 || true
          ip -6 rule del from 2602:fe18::/60 table 100 || true
          ip -6 route del default dev wg-aeolus table 100 || true
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
