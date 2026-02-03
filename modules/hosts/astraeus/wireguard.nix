{
  flake.nixosModules.astraeus =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      ip = lib.getExe' pkgs.iproute2 "ip";
      iptables = lib.getExe' pkgs.iptables "iptables";
      ip6tables = lib.getExe' pkgs.iptables "ip6tables";
    in
    {
      networking.wireguard.interfaces.wg-aeolus = {
        privateKeyFile = config.sops.secrets."wireguard/private_key".path;
        allowedIPsAsRoutes = false;

        postSetup = ''
          ${ip} rule add from 23.152.236.0/28 lookup 100
          ${ip} route add default dev wg-aeolus table 100

          ${ip} -6 rule add from 2602:fe18::/48 lookup 100
          ${ip} -6 route add default dev wg-aeolus table 100

          ${iptables} -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -o wg-aeolus -j TCPMSS --clamp-mss-to-pmtu
          ${iptables} -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -i wg-aeolus -j TCPMSS --clamp-mss-to-pmtu
          ${ip6tables} -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -o wg-aeolus -j TCPMSS --clamp-mss-to-pmtu
          ${ip6tables} -t mangle -A FORWARD -p tcp --tcp-flags SYN,RST SYN -i wg-aeolus -j TCPMSS --clamp-mss-to-pmtu
        '';

        postShutdown = ''
          ${ip} rule del from 23.152.236.0/28 lookup 100 || true
          ${ip} route del default dev wg-aeolus table 100 || true

          ${ip} -6 rule del from 2602:fe18::/48 lookup 100 || true
          ${ip} -6 route del default dev wg-aeolus table 100 || true
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
