{
  flake.nixosModules.zephyrus =
    { config, ... }:
    {
      networking.wg-quick.interfaces.wg0 = {
        address = [ "10.0.70.2/32" ];
        dns = [ "10.0.70.1" ];
        privateKeyFile = config.sops.secrets."wg0/private_key".path;

        peers = [
          {
            publicKey = "GcdVh6t9T3IqpAcbyzxaS3HWGLvtpIKVUvBs9IDysAc=";
            presharedKeyFile = config.sops.secrets."wg0/preshared_key".path;
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

      networking.wg-quick.interfaces.wg1 = {
        address = [
          "23.152.236.2/32"
          "2602:fe18::2/128"
        ];
        privateKeyFile = config.sops.secrets."wg1/private_key".path;

        peers = [
          {
            publicKey = "KyEVt7nfNKSuIcRYBQ0tbiJ5cSH2xl+zngQiQOYVl3o=";
            presharedKeyFile = config.sops.secrets."wg1/preshared_key".path;
            allowedIPs = [
              "23.152.236.32/28"
              "2602:fe18:2::/48"
            ];
            endpoint = "144.202.48.125:51821";
            persistentKeepalive = 25;
          }
        ];
      };

      systemd.services."wg-quick-wg0" = {
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
      };

      systemd.services."wg-quick-wg1" = {
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
      };
    };
}
