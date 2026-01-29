{
  flake.nixosModules.aeolus =
    { config, lib, ... }:
    {
      services.bird = {
        enable = true;
        checkConfig = false;
        autoReload = false;
        config = "";
      };

      environment.etc."bird/bird.conf".source = lib.mkForce config.sops.templates."bird.conf".path;

      systemd.services.bird = {
        wants = [ "sops-nix.service" ];
        after = [ "sops-nix.service" ];
        restartTriggers = [ config.sops.templates."bird.conf".content ];
      };

      sops.templates."bird.conf" = {
        owner = "bird";
        group = "bird";
        content = ''
          log syslog all;

          router id 45.63.69.57;

          define TAKOYAKI_NET_AS = 402127;
          define TAKOYAKI_NET_V4 = [ 23.152.236.0/24 ];
          define TAKOYAKI_NET_V6 = [ 2602:fe18::/48 ];

          define BOGON_V4 = [
            0.0.0.0/8+,
            10.0.0.0/8+,
            100.64.0.0/10+,
            127.0.0.0/8+,
            169.254.0.0/16+,
            172.16.0.0/12+,
            192.0.2.0/24+,
            192.88.99.0/24+,
            192.168.0.0/16+,
            198.18.0.0/15+,
            198.51.100.0/24+,
            203.0.113.0/24+,
            224.0.0.0/4+,
            240.0.0.0/4+
          ];

          define BOGON_V6 = [
            ::/8+,
            0100::/64+,
            2001:2::/48+,
            2001:10::/28+,
            2001:db8::/32+,
            2002::/16+,
            3ffe::/16+,
            5f00::/16+,
            fc00::/7+,
            fe80::/10+,
            fec0::/10+,
            ff00::/8+
          ];

          define BOGON_ASNS = [
            0,
            23456,
            64496..64511,
            64512..65534,
            65535,
            65536..65551,
            65552..131071,
            4200000000..4294967294,
            4294967295
          ];

          filter import_v4 {
            if net ~ BOGON_V4 then reject;
            if bgp_path.last ~ BOGON_ASNS then reject;
            if net.len < 8 || net.len > 24 then reject;
            accept;
          }

          filter import_v6 {
            if net ~ BOGON_V6 then reject;
            if bgp_path.last ~ BOGON_ASNS then reject;
            if net.len < 12 || net.len > 48 then reject;
            accept;
          }

          filter export_v4 {
            if net ~ BOGON_V4 then reject;
            if net ~ TAKOYAKI_NET_V4 then accept;
            if source = RTS_STATIC then accept;
            reject;
          }

          filter export_v6 {
            if net ~ BOGON_V6 then reject;
            if net ~ TAKOYAKI_NET_V6 then accept;
            if source = RTS_STATIC then accept;
            reject;
          }

          protocol device {
            scan time 10;
          }

          protocol direct {
            ipv4;
            ipv6;
            interface "enp1s0";
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
            description "Vultr IPv4";
            local 45.63.69.57 as TAKOYAKI_NET_AS;
            neighbor 169.254.169.254 as 64515;
            multihop 2;
            authentication md5;
            password "${config.sops.placeholder."bird/vultr/bgp_password"}";
            graceful restart on;

            ipv4 {
              import filter import_v4;
              export filter export_v4;
            };
          }

          protocol bgp vultr_v6 {
            description "Vultr IPv6";
            local 2001:19f0:5c00:41e3:5400:5ff:fee2:f46b as TAKOYAKI_NET_AS;
            neighbor 2001:19f0:ffff::1 as 64515;
            multihop 2;
            authentication md5;
            password "${config.sops.placeholder."bird/vultr/bgp_password"}";
            graceful restart on;

            ipv6 {
              import filter import_v6;
              export filter export_v6;
            };
          }
        '';
      };
    };
}
