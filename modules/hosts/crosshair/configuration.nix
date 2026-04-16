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
        self.nixosModules.hyprland
        self.nixosModules.nvidia
        self.nixosModules.theme
      ];

      boot = {
        kernelPackages = pkgs.linuxPackages_latest;

        loader = {
          systemd-boot = {
            enable = false;
            configurationLimit = 10;
          };
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

      networking = {
        hostName = "crosshair";
        networkmanager.enable = true;
      };

      zramSwap.enable = true;
      powerManagement.cpuFreqGovernor = "performance";

      services = {
        openssh = {
          enable = true;
          settings = {
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
          };
        };

        blueman.enable = true;
        udev.packages = [ pkgs.wooting-udev-rules ];
      };

      hardware = {
        opentabletdriver.enable = true;
        uinput.enable = true;
      };

      environment.systemPackages = [ pkgs.sbctl ];

      theme.scale = 1.25;

      system.stateVersion = "25.11";
    };

  flake.homeModules.crosshair =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.wootility ];
    };
}
