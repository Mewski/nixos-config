{
  flake.nixosModules.astraeus =
    { config, ... }:
    {
      networking.wireguard.interfaces.wg-aeolus = {
        ips = [
          "23.152.236.2/32"
          "2602:fe18::2/128"
        ];
        privateKeyFile = config.sops.secrets."wireguard/private_key".path;

        peers = [
          {
            publicKey = "Ez3Fx1SmQHoPEuGasq235KNMPr3TqK6CCPE+VTnwUCk=";
            presharedKeyFile = config.sops.secrets."wireguard/aeolus/preshared_key".path;
            endpoint = "aeolus.takoyaki.io:51820";
            allowedIPs = [
              "0.0.0.0/0"
              "::/0"
            ];
            persistentKeepalive = 25;
          }
        ];
      };
    };
}
