{ inputs, self, ... }:
{
  flake.nixosConfigurations.crosshair = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.crosshair ];
  };

  flake.nixosModules.crosshair =
    { pkgs, ... }:
    {
      imports = [
        inputs.disko.nixosModules.default
        inputs.lanzaboote.nixosModules.lanzaboote

        self.diskoConfigurations.crosshair

        self.nixosModules.nvidia

        self.nixosModules.desktop
        self.nixosModules.development
        self.nixosModules.gaming
      ];

      boot = {
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;

        lanzaboote = {
          enable = false;
          pkiBundle = "/var/lib/sbctl";
        };
      };

      networking = {
        hostName = "crosshair";

        firewall = {
          enable = true;

          allowedTCPPorts = [ ];

          allowedUDPPorts = [ ];
        };
      };

      services.openssh.enable = true;

      services.blueman.enable = true;

      services.udev.packages = with pkgs; [
        wooting-udev-rules
      ];

      environment.systemPackages = with pkgs; [
        sbctl
      ];

      system.stateVersion = "25.11";
    };

  flake.homeModules.crosshair =
    { pkgs, ... }:
    {
      imports = [
        self.homeModules.desktop
        self.homeModules.development
        self.homeModules.gaming
      ];

      wayland.windowManager.hyprland.settings = {
        monitor = [
          ", preferred, auto, 1"
        ];
      };

      home.packages = with pkgs; [
        wootility
      ];
    };
}
