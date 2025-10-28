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
        inputs.home-manager.nixosModules.home-manager
        inputs.lanzaboote.nixosModules.lanzaboote
        inputs.nixos-hardware.nixosModules.asus-zephyrus-gu605my

        self.diskoConfigurations.zephyrus

        self.nixosModules.desktop

        self.nixosModules.hyprland

        self.nixosModules.nix

        self.nixosModules.mewski
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

        loader.systemd-boot.enable = true;
        lanzaboote = {
          enable = false;
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

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        users.mewski = {
          imports = [ self.homeModules.zephyrus ];
        };
      };

      environment.systemPackages = with pkgs; [
        sbctl
      ];

      system.stateVersion = "25.11";
    };

  flake.homeModules.zephyrus =
    { pkgs, lib, ... }:
    {
      imports = [
        self.homeModules.hyprland
        self.homeModules.git
        self.homeModules.kitty
        self.homeModules.nixvim

        self.homeModules.mewski
      ];

      wayland.windowManager.hyprland.settings = {
        monitor = [
          "eDP-1, 2560x1600@240, 0x0, 1.25, vrr, 1, bitdepth, 10"
        ];

        env = [
          "ELECTRON_OZONE_PLATFORM_HINT,auto"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "LIBVA_DRIVER_NAME,nvidia"
          "NVD_BACKEND,direct"
        ];

        bindel = [
          ",XF86KbdBrightnessDown, exec, ${lib.getExe pkgs.brightnessctl} -d asus::kbd_backlight set 1-"
          ",XF86KbdBrightnessUp, exec, ${lib.getExe pkgs.brightnessctl} -d asus::kbd_backlight set 1+"

          ",XF86MonBrightnessDown, exec, ${lib.getExe pkgs.brightnessctl} -d intel_backlight -e4 -n2 set 5%-"
          ",XF86MonBrightnessUp, exec, ${lib.getExe pkgs.brightnessctl} -d intel_backlight -e4 -n2 set 5%+"
        ];
      };
    };
}
