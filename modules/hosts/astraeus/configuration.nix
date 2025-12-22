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
        };
      };

      networking = {
        hostName = "astraeus";

        useDHCP = false;

        interfaces.ens1f0.ipv4.addresses = [
          {
            address = "10.0.1.51";
            prefixLength = 24;
          }
        ];

        defaultGateway = "10.0.1.1";
        nameservers = [ "10.0.1.1" ];

        firewall = {
          enable = true;

          allowedTCPPorts = [ 22 ];

          allowedUDPPorts = [ ];
        };
      };

      services.openssh.enable = true;

      environment.systemPackages = with pkgs; [
        sbctl
      ];

      system.stateVersion = "25.11";
    };
}
