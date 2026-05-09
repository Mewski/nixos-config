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
        self.nixosModules.niri
        self.nixosModules.nvidia
        self.nixosModules.theme
      ];

      boot = {
        kernelPackages = pkgs.linuxPackages_latest;

        kernelParams = [
          "pcie_aspm.policy=powersupersave"
          "intel_iommu=on"
          "iommu=pt"
        ];

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
        hostName = "zephyrus";
        networkmanager = {
          enable = true;
          wifi.powersave = true;
        };
        firewall.allowedTCPPorts = [ 13367 ];
      };

      zramSwap.enable = true;

      virtualisation.spiceUSBRedirection.enable = true;

      systemd.settings.Manager = {
        DefaultTimeoutStartSec = "30s";
        DefaultTimeoutStopSec = "30s";
        DefaultTimeoutAbortSec = "30s";
        DefaultRestartSec = "5s";
      };

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
        udisks2.enable = true;

        resolved = {
          enable = true;
          settings.Resolve = {
            DNSOverTLS = "opportunistic";
            FallbackDNS = [
              "1.1.1.1#cloudflare-dns.com"
              "1.0.0.1#cloudflare-dns.com"
              "2606:4700:4700::1111#cloudflare-dns.com"
              "2606:4700:4700::1001#cloudflare-dns.com"
            ];
          };
        };

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

      hardware = {
        flipperzero.enable = true;
        opentabletdriver.enable = true;
        uinput.enable = true;
      };

      theme.scale = 1.25;

      system.stateVersion = "25.11";
    };

  flake.homeModules.zephyrus =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.wootility ];
    };
}
