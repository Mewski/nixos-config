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
        self.nixosModules.desktop
        self.nixosModules.development
        self.nixosModules.gaming
        self.nixosModules.security
        self.nixosModules.nvidia
        self.nixosModules.tablet
        self.nixosModules.theme
      ];

      boot = {
        kernelPackages = pkgs.linuxPackages_latest;

        loader = {
          systemd-boot.enable = false;
          efi.canTouchEfiVariables = true;
        };

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

      powerManagement.cpuFreqGovernor = "performance";

      networking = {
        hostName = "crosshair";
        networkmanager.enable = true;
      };

      zramSwap.enable = true;

      services = {
        openssh.enable = true;
        blueman.enable = true;
        udev.packages = [ pkgs.wooting-udev-rules ];
      };

      environment.systemPackages = [ pkgs.sbctl ];

      system.stateVersion = "25.11";
    };

  flake.homeModules.crosshair =
    { pkgs, ... }:
    {
      wayland.windowManager.hyprland.settings.monitor = [
        "DP-3, 3840x2160@240, 0x0, 1.25, vrr, 0, bitdepth, 10"
        ", preferred, auto, 1"
      ];

      home.packages = [ pkgs.wootility ];
    };
}
