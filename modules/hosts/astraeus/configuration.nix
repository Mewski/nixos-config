{ inputs, self, ... }:
{
  flake.nixosConfigurations.astraeus = inputs.nixpkgs-stable.lib.nixosSystem {
    modules = [ self.nixosModules.astraeus ];
  };

  flake.nixosModules.astraeus =
    { pkgs, ... }:
    {
      imports = [
        inputs.disko.nixosModules.default
        inputs.lanzaboote.nixosModules.lanzaboote

        self.diskoConfigurations.astraeus

        self.nixosModules.server
      ];

      boot = {
        loader.systemd-boot.enable = false;
        loader.efi.canTouchEfiVariables = true;

        lanzaboote = {
          enable = true;
          pkiBundle = "/var/lib/sbctl";
          autoGenerateKeys.enable = true;
          autoEnrollKeys = {
            enable = true;
            autoReboot = true;
          };
        };
      };

      networking = {
        hostName = "astraeus";

        useDHCP = false;

        nameservers = [ "10.0.1.1" ];

        firewall = {
          enable = true;
          allowedTCPPorts = [ 22 ];
          allowedUDPPorts = [ ];
        };

        nftables = {
          enable = true;
          tables.smtp-nat = {
            family = "ip6";
            content = ''
              chain postrouting {
                type nat hook postrouting priority srcnat; policy accept;
                tcp dport { 25, 465, 587 } snat to 2601:244:4b06:5be1::52
              }
            '';
          };
        };
      };

      systemd.network = {
        enable = true;
        networks."10-ens1f0" = {
          matchConfig.Name = "ens1f0";
          networkConfig.IPv6AcceptRA = false;
          addresses = [
            { Address = "10.0.1.51/24"; }
            { Address = "2601:244:4b06:5be1::51/64"; }
            {
              Address = "2601:244:4b06:5be1::52/64";
              PreferredLifetime = 0;
            }
          ];
          routes = [
            { Gateway = "10.0.1.1"; }
            { Gateway = "fe80::9e05:d6ff:fec1:3143"; }
          ];
          linkConfig.RequiredForOnline = "routable";
        };
      };

      zramSwap = {
        enable = true;
        memoryMax = 64 * 1024 * 1024 * 1024;
      };

      services.openssh = {
        enable = true;

        listenAddresses = [
          {
            addr = "10.0.1.51";
            port = 22;
          }
          {
            addr = "[2601:244:4b06:5be1::51]";
            port = 22;
          }
          {
            addr = "[2601:244:4b06:5be1::52]";
            port = 22;
          }
        ];

        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };

        extraConfig = ''
          Match LocalAddress 10.0.1.51,2601:244:4b06:5be1::51
            AllowUsers mewski git

          Match LocalAddress 2601:244:4b06:5be1::52
            AllowUsers git
        '';
      };

      environment.systemPackages = [
        pkgs.sbctl
      ];

      system.stateVersion = "25.11";
    };
}
