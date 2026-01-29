{
  flake.nixosModules.zephyrus =
    { config, ... }:
    {
      networking.wg-quick.interfaces.argus = {
        address = [ "10.0.70.2/32" ];
        dns = [ "10.0.70.1" ];
        privateKeyFile = config.sops.secrets."wireguard/argus/private_key".path;

        peers = [
          {
            publicKey = "GcdVh6t9T3IqpAcbyzxaS3HWGLvtpIKVUvBs9IDysAc=";
            presharedKeyFile = config.sops.secrets."wireguard/argus/preshared_key".path;
            allowedIPs = [
              "10.0.10.0/24"
              "10.0.20.0/24"
              "10.0.30.0/24"
              "10.0.40.0/24"
              "10.0.60.0/24"
              "10.0.70.0/24"
            ];
            endpoint = "argus.takoyaki.io:51820";
            persistentKeepalive = 25;
          }
        ];
      };

      systemd.services."wg-quick-argus" = {
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
      };
    };
}
