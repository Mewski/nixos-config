{
  flake.nixosModules.aeolus = {
    networking.firewall = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [ 53 ];
    };

    services.unbound = {
      enable = true;
      settings = {
        server = {
          interface = [
            "127.0.0.1"
            "::1"
            "23.152.236.1"
            "2602:fe18::1"
          ];
          access-control = [
            "127.0.0.0/8 allow"
            "::1/128 allow"
            "23.152.236.0/24 allow"
            "2602:fe18::/40 allow"
          ];
        };
        forward-zone = [
          {
            name = ".";
            forward-addr = [
              "1.1.1.1@853"
              "1.0.0.1@853"
              "2606:4700:4700::1111@853"
              "2606:4700:4700::1001@853"
            ];
            forward-tls-upstream = true;
          }
        ];
      };
    };
  };
}
