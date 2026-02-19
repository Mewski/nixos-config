{
  flake.nixosModules.aeolus =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      ip = lib.getExe' pkgs.iproute2 "ip";
    in
    {
      networking.wireguard.interfaces.wg0 = {
        listenPort = 51820;
        privateKeyFile = config.sops.secrets."wireguard/private_key".path;

        ips = [
          "23.152.236.1/32"
          "2602:fe18::1/128"
        ];

        postSetup = ''
          ${ip} route add 23.152.236.0/28 dev wg0
          ${ip} route add 23.152.236.16/28 dev wg0
          ${ip} -6 route add 2602:fe18::/48 dev wg0
          ${ip} -6 route add 2602:fe18:1::/48 dev wg0
        '';

        postShutdown = ''
          ${ip} route del 23.152.236.0/28 dev wg0 || true
          ${ip} route del 23.152.236.16/28 dev wg0 || true
          ${ip} -6 route del 2602:fe18::/48 dev wg0 || true
          ${ip} -6 route del 2602:fe18:1::/48 dev wg0 || true
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
          {
            publicKey = "FYjYrpCpShODVevBeBo99oViDU0hyFkx/NAE6GtLUCI=";
            presharedKeyFile = config.sops.secrets."wireguard/ares/preshared_key".path;
            allowedIPs = [
              "23.152.236.16/28"
              "2602:fe18:1::/48"
            ];
          }
        ];
      };
    };
}
