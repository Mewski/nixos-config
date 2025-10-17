{
  inputs,
  self,
  config,
  ...
}:
{
  flake.nixosConfigurations.zephyrus = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.disko.nixosModules.disko

      self.nixosModules.zephyrus
    ];
  };

  flake.nixosModules.zephyrus =
    { pkgs, ... }:
    {
      imports = [
        inputs.lanzaboote.nixosModules.lanzaboote
        inputs.nixos-hardware.nixosModules.asus-zephyrus-gu605my

        self.nixosModules.impermanence
        self.nixosModules.nix

        self.nixosModules.fish

        self.nixosModules.desktop

        self.nixosModules.hyprland

        self.diskoConfigurations.zephyrus

        self.nixosModules.mewski
      ];

      boot = {
        loader.efi.canTouchEfiVariables = true;

        lanzaboote = {
          enable = true;
          pkiBundle = "/var/lib/sbctl";
        };

        initrd.luks.devices = {
          cryptroot = {
            device = "/dev/disk/by-partlabel/cryptroot";
            allowDiscards = true;
          };

          cryptswap = {
            device = "/dev/disk/by-partlabel/cryptswap";
            allowDiscards = true;
          };
        };

        resumeDevice = "/dev/mapper/cryptswap";
      };

      swapDevices = [
        { device = "/dev/mapper/cryptswap"; }
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

      networking = {
        hostName = "zephyrus";

        firewall.enable = false;
        networkmanager.enable = true;
      };

      services.xserver.videoDrivers = [
        "modesetting"
        "nvidia"
      ];

      nixpkgs.config.cudaSupport = true;

      environment.systemPackages = with pkgs; [
        sbctl
      ];

      system.stateVersion = "25.11";
    };

  flake.homeConfigurations."mewski@zephyrus" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = config.system.build.pkgs;
    modules = [
      self.homeModules.fish

      self.homeModules.hyprland

      self.homeModules.git
      self.homeModules.kitty
      self.homeModules.nixvim
    ];

    home.stateVersion = "25.11";
  };
}
