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
        privateKeyFile = config.sops.secrets."wg0/private_key".path;

        ips = [
          "23.152.236.1/32"
          "2602:fe18::1/128"
        ];

        postSetup = ''
          ${ip} route add 23.152.236.16/28 dev wg0
          ${ip} route add 23.152.236.32/28 dev wg0
          ${ip} -6 route add 2602:fe18:1::/48 dev wg0
          ${ip} -6 route add 2602:fe18:2::/48 dev wg0
        '';

        postShutdown = ''
          ${ip} route del 23.152.236.16/28 dev wg0 || true
          ${ip} route del 23.152.236.32/28 dev wg0 || true
          ${ip} -6 route del 2602:fe18:1::/48 dev wg0 || true
          ${ip} -6 route del 2602:fe18:2::/48 dev wg0 || true
        '';

        peers = [
          {
            publicKey = "Vs0DokjJNb9Da+GRm6p15r1pZlqR2U4FNHKEEnCRfEU=";
            presharedKeyFile = config.sops.secrets."wg0/astraeus/preshared_key".path;
            allowedIPs = [
              "23.152.236.16/28"
              "2602:fe18:1::/48"
            ];
          }
          {
            publicKey = "FYjYrpCpShODVevBeBo99oViDU0hyFkx/NAE6GtLUCI=";
            presharedKeyFile = config.sops.secrets."wg0/ares/preshared_key".path;
            allowedIPs = [
              "23.152.236.32/28"
              "2602:fe18:2::/48"
            ];
          }
        ];
      };

      networking.wireguard.interfaces.wg1 = {
        listenPort = 51821;
        privateKeyFile = config.sops.secrets."wg1/private_key".path;

        ips = [
          "23.152.236.1/28"
          "2602:fe18::1/48"
        ];

        peers = [
          {
            publicKey = "XhDTjgVMAXUDGKK9mMp3HqulvgaaTw+8/qri2ToL4yw=";
            presharedKeyFile = config.sops.secrets."wg1/mewski/preshared_key".path;
            allowedIPs = [
              "23.152.236.2/32"
              "2602:fe18::2/128"
            ];
          }
        ];
      };
    };
}
