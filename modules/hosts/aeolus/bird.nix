{
  flake.nixosModules.aeolus =
    { config, pkgs, ... }:
    {
      sops.templates."bird.conf" = {
        owner = "bird";
        group = "bird";
        content = ''
          log syslog all;
          router id 144.202.48.125;

          define OWN_AS = 402127;
          define OWN_V4 = [ 23.152.236.0/24 ];
          define OWN_V6 = [ 2602:fe18::/48 ];

          protocol device {
            scan time 10;
          }

          protocol direct {
            ipv4;
            ipv6;
          }

          protocol static static_v4 {
            ipv4;
            route 23.152.236.0/24 blackhole;
          }

          protocol static static_v6 {
            ipv6;
            route 2602:fe18::/48 blackhole;
          }

          protocol kernel kernel_v4 {
            ipv4 {
              import none;
              export none;
            };
          }

          protocol kernel kernel_v6 {
            ipv6 {
              import none;
              export none;
            };
          }

          protocol bgp vultr_v4 {
            local 144.202.48.125 as OWN_AS;
            neighbor 169.254.169.254 as 64515;
            multihop 2;
            password "${config.sops.placeholder."bird/vultr/bgp_password"}";

            ipv4 {
              import all;
              export where net ~ OWN_V4;
            };
          }

          protocol bgp vultr_v6 {
            local 2001:19f0:5c00:44fd:5400:5ff:feea:4a32 as OWN_AS;
            neighbor 2001:19f0:ffff::1 as 64515;
            multihop 2;
            password "${config.sops.placeholder."bird/vultr/bgp_password"}";

            ipv6 {
              import all;
              export where net ~ OWN_V6;
            };
          }
        '';
      };

      systemd.services.bird = {
        description = "BIRD Internet Routing Daemon";
        wantedBy = [ "multi-user.target" ];
        wants = [ "sops-nix.service" ];
        after = [
          "network.target"
          "sops-nix.service"
        ];
        restartTriggers = [ config.sops.templates."bird.conf".content ];

        serviceConfig = {
          Type = "forking";
          User = "bird";
          Group = "bird";
          ExecStart = "${pkgs.bird3}/bin/bird -c ${config.sops.templates."bird.conf".path}";
          ExecReload = "${pkgs.bird3}/bin/birdc configure";
          Restart = "on-failure";
          RuntimeDirectory = "bird";
          AmbientCapabilities = [
            "CAP_NET_ADMIN"
            "CAP_NET_BIND_SERVICE"
            "CAP_NET_RAW"
          ];
        };
      };
    };
}
