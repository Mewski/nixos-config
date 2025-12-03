{
  flake.nixosModules.zephyrus =
    { config, ... }:
    {
      sops.secrets."wireguard/home/interface/private-key" = { };

      networking.wg-quick.interfaces.wg-home = {
        autostart = false;
        privateKeyFile = config.sops.secrets."wireguard/home/interface/private-key".path;
        address = [ "10.0.1.3/24" ];

        peers = [
          {
            publicKey = "GcdVh6t9T3IqpAcbyzxaS3HWGLvtpIKVUvBs9IDysAc=";
            allowedIPs = [
              "0.0.0.0/0"
              "::/0"
            ];
            endpoint = "73.176.238.76:51820";
            persistentKeepalive = 25;
          }
        ];
      };
    };
}
