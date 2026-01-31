{
  flake.nixosModules.aeolus =
    { config, ... }:
    {
      networking.wireguard.interfaces.wg-astraeus = {
        listenPort = 51820;
        privateKeyFile = config.sops.secrets."wireguard/private_key".path;

        ips = [
          "23.152.236.1/32"
          "2602:fe18::1/128"
        ];

        postSetup = ''
          ip route add 23.152.236.0/28 dev wg-astraeus
          ip -6 route add 2602:fe18::/48 dev wg-astraeus
        '';

        postShutdown = ''
          ip route del 23.152.236.0/28 dev wg-astraeus || true
          ip -6 route del 2602:fe18::/48 dev wg-astraeus || true
        '';

        peers = [
          {
            publicKey = "Vs0DokjJNb9Da+GRm6p15r1pZlqR2U4FNHKEEnCRfEU=";
            presharedKeyFile = config.sops.secrets."wireguard/astraeus/preshared_key".path;
            allowedIPs = [
              "23.152.236.0/28"
              "2602:fe18::/48"
            ];
          }
        ];
      };
    };
}
