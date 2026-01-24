{
  flake.nixosModules.zephyrus =
    { config, ... }:
    {
      networking.wg-quick.interfaces.ord-core-01 = {
        address = [ "10.0.70.2/32" ];
        dns = [ "10.0.70.1" ];
        privateKeyFile = config.sops.secrets."wireguard/ord-core-01/private_key".path;

        peers = [
          {
            publicKey = "GcdVh6t9T3IqpAcbyzxaS3HWGLvtpIKVUvBs9IDysAc=";
            presharedKeyFile = config.sops.secrets."wireguard/ord-core-01/preshared_key".path;
            allowedIPs = [ "0.0.0.0/0" ];
            endpoint = "ord-core-01.takoyaki.io:51820";
            persistentKeepalive = 25;
          }
        ];
      };

      systemd.services."wg-quick-ord-core-01" = {
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
      };
    };
}
