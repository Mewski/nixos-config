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
      systemd.services.wireguard-wg0 = {
        after = [ "network-addresses-vmbr1.service" ];
        requires = [ "network-addresses-vmbr1.service" ];
      };

      networking.wireguard.interfaces.wg0 = {
        privateKeyFile = config.sops.secrets."wireguard/private_key".path;
        allowedIPsAsRoutes = false;

        ips = [
          "23.152.236.16/32"
          "2602:fe18:1::1/128"
        ];

        postSetup = ''
          ${ip} rule add from 23.152.236.16/28 lookup 100 || true
          ${ip} route replace 23.152.236.16/28 dev vmbr1 table 100
          ${ip} route replace default dev wg0 table 100

          ${ip} -6 rule add from 2602:fe18:1::/48 lookup 100 || true
          ${ip} -6 route replace 2602:fe18:1::/64 dev vmbr1 table 100
          ${ip} -6 route replace 2602:fe18:1:10::/64 via 2602:fe18:1::2 dev vmbr1 table 100
          ${ip} -6 route replace default dev wg0 table 100
        '';

        postShutdown = ''
          ${ip} rule del from 23.152.236.16/28 lookup 100 || true
          ${ip} route del 23.152.236.16/28 dev vmbr1 table 100 || true
          ${ip} route del default dev wg0 table 100 || true

          ${ip} -6 rule del from 2602:fe18:1::/48 lookup 100 || true
          ${ip} -6 route del 2602:fe18:1::/64 dev vmbr1 table 100 || true
          ${ip} -6 route del 2602:fe18:1:10::/64 via 2602:fe18:1::2 dev vmbr1 table 100 || true
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
