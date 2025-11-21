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
    { pkgs, ... }:
    {
      imports = [
        inputs.disko.nixosModules.disko
        inputs.lanzaboote.nixosModules.lanzaboote
        inputs.nixos-hardware.nixosModules.asus-zephyrus-gu605my

        self.diskoConfigurations.zephyrus

        self.nixosModules.preferences
        self.nixosModules.theme
        self.nixosModules.impermanence
        self.nixosModules.persist
        self.nixosModules.secrets
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
        hostName = "zephyrus";
        networkmanager.enable = true;
        firewall.enable = true;
      };

      services.openssh.enable = true;

      services.blueman.enable = true;

      environment.systemPackages = with pkgs; [
        sbctl
      ];

      system.stateVersion = "25.11";
    };

  flake.homeModules.zephyrus =
    { pkgs, lib, ... }:
    {
      imports = [
        self.homeModules.theme
        self.homeModules.secrets
        self.homeModules.hyprland
        self.homeModules.fish
        self.homeModules.git
        self.homeModules.kitty
        self.homeModules.nixvim
        self.homeModules.zed-editor
        self.homeModules.zen-browser
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

      persist.directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        "Projects"
        "nixos-config"
        {
          directory = ".local/share/keyrings";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
      ];

      persist.files = [
        ".local/share/fish/fish_history"
      ];
    };
}
