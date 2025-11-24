{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.crosshair = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.crosshair ];
  };

  flake.nixosModules.crosshair =
    { pkgs, ... }:
    {
      imports = [
        inputs.disko.nixosModules.disko
        inputs.lanzaboote.nixosModules.lanzaboote

        self.diskoConfigurations.crosshair

        self.nixosModules.preferences
        self.nixosModules.theme
        self.nixosModules.impermanence
        self.nixosModules.persist
        self.nixosModules.user
        self.nixosModules.home-manager
        self.nixosModules.nvidia
        self.nixosModules.desktop
        self.nixosModules.hyprland
        self.nixosModules.nix
        self.nixosModules.pipewire
        self.nixosModules.fish
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
        hostName = "crosshair";
        networkmanager.enable = true;
        firewall.enable = true;
      };

      services.openssh.enable = true;

      services.blueman.enable = true;

      services.fstrim.enable = true;

      environment.systemPackages = with pkgs; [
        sbctl
      ];

      system.stateVersion = "25.11";
    };

  flake.homeModules.crosshair = {
    imports = [
      self.homeModules.theme
      self.homeModules.hyprland
      self.homeModules.fish
      self.homeModules.git
      self.homeModules.kitty
      self.homeModules.nixvim
      self.homeModules.nixcord
      self.homeModules.zed-editor
      self.homeModules.zen-browser
    ];

    wayland.windowManager.hyprland.settings = {
      monitor = [
        "eDP-1, 3840x2160@240, 0x0, 1.25, vrr, 1, bitdepth, 10"
      ];

      env = [
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "LIBVA_DRIVER_NAME,nvidia"
        "NVD_BACKEND,direct"
      ];
    };

    persist.directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      "Projects"
      ".nixos-config"
      {
        directory = ".local/share/keyrings";
        mode = "0700";
      }
      {
        directory = ".ssh";
        mode = "0700";
      }
    ];
  };
}
