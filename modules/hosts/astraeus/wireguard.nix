{
  flake.nixosModules.astraeus =
    { config, ... }:
    {
      networking.wireguard.interfaces.wg-aeolus = {
        ips = [ ];
        privateKeyFile = config.sops.secrets."wireguard/private_key".path;

        peers = [
          {
            publicKey = "Ez3Fx1SmQHoPEuGasq235KNMPr3TqK6CCPE+VTnwUCk=";
            presharedKeyFile = config.sops.secrets."wireguard/aeolus/preshared_key".path;
            endpoint = "aeolus.takoyaki.io:51820";
            allowedIPs = [
              "23.152.236.0/28"
              "2602:fe18::/60"
            ];
            persistentKeepalive = 25;
          }
        ];
      };
    };
}
