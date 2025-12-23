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
        hostName = "crosshair";

        firewall = {
          enable = true;

          allowedTCPPorts = [ ];

          allowedUDPPorts = [ ];
        };
      };

      services.openssh.enable = true;

      services.blueman.enable = true;

      services.udev.packages = [
        pkgs.wooting-udev-rules
      ];

      environment.systemPackages = [
        pkgs.sbctl
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
          "DP-5, 3840x2160@240, 0x0, 1.25, vrr, 1, bitdepth, 10"
          ", preferred, auto, 1"
        ];
      };

      home.packages = [
        pkgs.wootility
      ];
    };
}
