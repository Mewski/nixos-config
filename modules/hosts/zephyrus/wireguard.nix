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
            endpoint = "udm.takoyaki.io:51820";
            persistentKeepalive = 25;
            allowedIPs = [
              "10.0.10.0/24"
              "10.0.20.0/24"
              "10.0.30.0/24"
              "10.0.40.0/24"
              "10.0.60.0/24"
              "10.0.70.0/24"
            ];
          }
        ];
      };

      networking.wg-quick.interfaces.wg1 = {
        address = [ "10.0.80.2/32" ];
        dns = [ "10.0.80.1" ];
        privateKeyFile = config.sops.secrets."wg1/private_key".path;

        peers = [
          {
            publicKey = "/RtyxzBBs6u5vAIzo3IkF+Lai4nfdOCjrsrO7alCH1g=";
            presharedKeyFile = config.sops.secrets."wg1/preshared_key".path;
            endpoint = "cyberrange.takoyaki.sh:51821";
            persistentKeepalive = 25;
            allowedIPs = [
              "10.0.50.0/24"
              "10.0.80.0/24"
            ];
          }
        ];
      };

      networking.wg-quick.interfaces.wg2 = {
        address = [ "192.168.30.137/32" ];
        privateKeyFile = config.sops.secrets."wg2/private_key".path;

        peers = [
          {
            publicKey = "n34BKPybcDFPO0E+HHNDTfY5EAtuMxHrHE+ireTi7gU=";
            presharedKeyFile = config.sops.secrets."wg2/preshared_key".path;
            endpoint = "cyberrange.takoyaki.sh:51822";
            persistentKeepalive = 25;
            allowedIPs = [
              "192.168.20.0/24"
              "192.168.30.0/24"
              "192.168.40.0/24"
            ];
          }
        ];
      };

      systemd.services = {
        "wg-quick-wg0" = {
          wants = [ "network-online.target" ];
          after = [ "network-online.target" ];
          serviceConfig = {
            Restart = "on-failure";
            RestartSec = 5;
          };
        };

        "wg-quick-wg1" = {
          wants = [ "network-online.target" ];
          after = [ "network-online.target" ];
          serviceConfig = {
            Restart = "on-failure";
            RestartSec = 5;
          };
        };

        "wg-quick-wg2" = {
          wants = [ "network-online.target" ];
          after = [ "network-online.target" ];
          serviceConfig = {
            Restart = "on-failure";
            RestartSec = 5;
          };
        };
      };
    };
}
