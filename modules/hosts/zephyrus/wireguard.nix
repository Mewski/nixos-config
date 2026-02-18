{
  flake.nixosModules.zephyrus =
    { config, ... }:
    {
      networking.wg-quick.interfaces.wg0 = {
        address = [ "10.0.70.2/32" ];
        dns = [ "10.0.70.1" ];
        privateKeyFile = config.sops.secrets."wireguard/udm/private_key".path;

        peers = [
          {
            publicKey = "GcdVh6t9T3IqpAcbyzxaS3HWGLvtpIKVUvBs9IDysAc=";
            presharedKeyFile = config.sops.secrets."wireguard/udm/preshared_key".path;
            allowedIPs = [
              "10.0.10.0/24"
              "10.0.20.0/24"
              "10.0.30.0/24"
              "10.0.40.0/24"
              "10.0.50.0/24"
              "10.0.60.0/24"
              "10.0.70.0/24"
            ];
            endpoint = "udm.takoyaki.io:51820";
            persistentKeepalive = 25;
          }
        ];
      };

      systemd.services."wg-quick-wg0" = {
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
      };
    };
}
