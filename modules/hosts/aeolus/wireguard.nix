{
  flake.nixosModules.aeolus =
    { config, ... }:
    {
      networking = {
        firewall.allowedUDPPorts = [ 51820 ];

        wireguard.interfaces.ord-core-01 = {
          ips = [
            "10.100.0.1/30"
            "2602:fe18::1/128"
          ];
          listenPort = 51820;
          privateKeyFile = config.sops.secrets."wireguard/private_key".path;
          postSetup = ''
            ip route add 23.152.236.0/24 dev ord-core-01
            ip -6 route add 2602:fe18::/48 dev ord-core-01
          '';
          postShutdown = ''
            ip route del 23.152.236.0/24 dev ord-core-01 || true
            ip -6 route del 2602:fe18::/48 dev ord-core-01 || true
          '';

          peers = [
            {
              publicKey = "VibSetNI4rvnaG8rTIh/qSnvj7XIMKyU50mJQpYqg1E=";
              presharedKeyFile = config.sops.secrets."wireguard/preshared_key".path;
              allowedIPs = [
                "10.100.0.2/32"
                "23.152.236.0/24"
                "2602:fe18::/48"
              ];
              persistentKeepalive = 25;
            }
          ];
        };
      };
    };
}
