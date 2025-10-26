{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.zephyrus = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.zephyrus ];
  };

  flake.nixosModules.zephyrus =
    { config, pkgs, ... }:
    {
      imports = [
        inputs.disko.nixosModules.disko

        self.nixosModules.desktop
        self.diskoConfigurations.zephyrus
      ];

      boot = {
        loader.efi.canTouchEfiVariables = true;

        initrd.luks.devices = {
          cryptroot = {
            device = "/dev/disk/by-partlabel/disk-main-root";
            allowDiscards = true;
          };
          cryptswap = {
            device = "/dev/disk/by-partlabel/disk-main-swap";
            allowDiscards = true;
          };
        };

        resumeDevice = "/dev/mapper/cryptswap";

        lanzaboote = {
          enable = true;
          pkiBundle = "/var/lib/sbctl";
        };
      };

      services.xserver.videoDrivers = [
        "modesetting"
        "nvidia"
      ];

      hardware = {
        graphics.extraPackages = with pkgs; [
          libva
          libvdpau
          nvidia-vaapi-driver
          vaapiVdpau
        ];

        nvidia = {
          open = false;
          package = config.boot.kernelPackages.nvidiaPackages.latest;
          powerManagement = {
            enable = true;
            finegrained = true;
          };
        };
      };

      nixpkgs.config.cudaSupport = true;

      networking = {
        hostName = "zephyrus";
        networkmanager.enable = true;
        firewall.enable = true;
      };

      environment.systemPackages = with pkgs; [
        sbctl
      ];
    };

  flake.homeConfigurations.zephyrus = inputs.home-manager.lib.homeManagerConfiguration {
    modules = [ self.homeModules.zephyrus ];
  };

  flake.homeModules.zephyrus = {

  };
}
