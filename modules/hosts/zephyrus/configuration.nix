{ inputs, self, ... }:
{
  flake.nixosConfigurations.zephyrus = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.zephyrus ];
  };

  flake.nixosModules.zephyrus =
    { pkgs, ... }:
    {
      imports = [
        inputs.disko.nixosModules.default
        inputs.lanzaboote.nixosModules.lanzaboote
        inputs.nixos-hardware.nixosModules.asus-zephyrus-gu605my
        self.diskoConfigurations.zephyrus
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

      networking = {
        hostName = "zephyrus";
        networkmanager.enable = true;
        firewall.allowedTCPPorts = [
          3000
        ];
      };

      zramSwap.enable = true;

      services = {
        logind.settings.Login.HandleLidSwitchDocked = "suspend";

        openssh = {
          enable = true;
          settings = {
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
          };
        };

        blueman.enable = true;
        resolved.enable = true;
        udev.packages = [
          pkgs.probe-rs-tools
          pkgs.python3Packages.chipwhisperer
          pkgs.wooting-udev-rules
        ];
      };

      environment.systemPackages = with pkgs; [
        openvpn
        sbctl
        tor-browser
      ];

      hardware.flipperzero.enable = true;

      theme.scale = 1.25;

      system.stateVersion = "25.11";
    };
}
