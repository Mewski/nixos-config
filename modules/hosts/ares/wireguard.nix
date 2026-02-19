{
  flake.nixosModules.ares =
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
        privateKeyFile = config.sops.secrets."wireguard/private_key".path;
        allowedIPsAsRoutes = false;

        ips = [
          "23.152.236.32/32"
          "2602:fe18:1::1/128"
        ];

        postSetup = ''
          ${ip} rule add from 23.152.236.32/27 lookup 100
          ${ip} rule add from 172.16.0.0/30 lookup 100
          ${ip} route add default dev wg0 table 100

          ${ip} -6 rule add from 2602:fe18:1::/48 lookup 100
          ${ip} -6 route add default dev wg0 table 100
        '';

        postShutdown = ''
          ${ip} rule del from 23.152.236.32/27 lookup 100 || true
          ${ip} rule del from 172.16.0.0/30 lookup 100 || true
          ${ip} route del default dev wg0 table 100 || true

          ${ip} -6 rule del from 2602:fe18:1::/48 lookup 100 || true
          ${ip} -6 route del default dev wg0 table 100 || true
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
