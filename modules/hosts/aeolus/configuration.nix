{ inputs, self, ... }:
{
  flake.nixosConfigurations.aeolus = inputs.nixpkgs-stable.lib.nixosSystem {
    modules = [ self.nixosModules.aeolus ];
  };

  flake.nixosModules.aeolus =
    { pkgs, ... }:
    {
      imports = [
        inputs.disko.nixosModules.default
        self.diskoConfigurations.aeolus
        self.nixosModules.router
      ];

      boot = {
        kernelPackages = pkgs.linuxPackages_latest;

        loader.grub = {
          enable = true;
          efiSupport = true;
          efiInstallAsRemovable = true;
          device = "nodev";
        };
      };

      networking = {
        hostName = "aeolus";
        domain = "takoyaki.io";
        useDHCP = false;
        nameservers = [ "127.0.0.1" ];

        interfaces.enp1s0 = {
          ipv4.addresses = [
            {
              address = "144.202.48.125";
              prefixLength = 23;
            }
          ];
          ipv4.routes = [
            {
              address = "0.0.0.0";
              prefixLength = 0;
              via = "144.202.48.1";
              options.src = "23.152.236.1";
            }
          ];
          ipv6.addresses = [
            {
              address = "2001:19f0:5c00:44fd:5400:5ff:feea:4a32";
              prefixLength = 64;
            }
          ];
          ipv6.routes = [
            {
              address = "::";
              prefixLength = 0;
              via = "fe80::fc00:5ff:feea:4a32";
              options.src = "2602:fe18::1";
            }
          ];
        };

        interfaces.lo = {
          ipv4.addresses = [
            {
              address = "23.152.236.1";
              prefixLength = 32;
            }
          ];
          ipv6.addresses = [
            {
              address = "2602:fe18::1";
              prefixLength = 128;
            }
          ];
        };

        firewall.allowedTCPPorts = [ 22 ];
      };

      zramSwap.enable = true;

      system.stateVersion = "25.11";
    };
}
