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
        inputs.disko.nixosModules.default
        inputs.lanzaboote.nixosModules.lanzaboote
        inputs.nixos-hardware.nixosModules.asus-zephyrus-gu605my

        self.diskoConfigurations.zephyrus

        self.nixosModules.desktop
        self.nixosModules.impermanence
        self.nixosModules.nvidia
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
    {
      pkgs,
      lib,
      ...
    }:
    {
      imports = [ self.homeModules.desktop ];

      wayland.windowManager.hyprland.settings = {
        monitor = [ "eDP-1, 2560x1600@240, 0x0, 1.25, vrr, 1, bitdepth, 10" ];

        env = [
          "ELECTRON_OZONE_PLATFORM_HINT,auto"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "LIBVA_DRIVER_NAME,nvidia"
          "NVD_BACKEND,direct"
        ];

        input.touchpad = {
          clickfinger_behavior = true;
          disable_while_typing = true;
          natural_scroll = true;
          scroll_factor = 0.25;
        };

        device = {
          name = "asup1207:00-093a:3012-touchpad";
          accel_profile = "flat";
          sensitivity = 0.55;
        };

        bindel = [
          ",XF86KbdBrightnessDown, exec, ${lib.getExe pkgs.brightnessctl} -d asus::kbd_backlight set 1- && ${lib.getExe pkgs.libnotify} -a osd -t 1000 -h string:x-dunst-stack-tag:kbd -h int:value:$(${lib.getExe pkgs.brightnessctl} -d asus::kbd_backlight -m | cut -d, -f4 | tr -d '%') 'Keyboard Brightness'"
          ",XF86KbdBrightnessUp, exec, ${lib.getExe pkgs.brightnessctl} -d asus::kbd_backlight set 1+ && ${lib.getExe pkgs.libnotify} -a osd -t 1000 -h string:x-dunst-stack-tag:kbd -h int:value:$(${lib.getExe pkgs.brightnessctl} -d asus::kbd_backlight -m | cut -d, -f4 | tr -d '%') 'Keyboard Brightness'"

          ",XF86MonBrightnessDown, exec, ${lib.getExe pkgs.brightnessctl} -d intel_backlight set 10%-; ${lib.getExe pkgs.brightnessctl} -d nvidia_0 set 10%-; ${lib.getExe pkgs.libnotify} -a osd -t 1000 -h string:x-dunst-stack-tag:brightness -h int:value:$(${lib.getExe pkgs.brightnessctl} -d intel_backlight -m | cut -d, -f4 | tr -d '%') 'Display Brightness'"
          ",XF86MonBrightnessUp, exec, ${lib.getExe pkgs.brightnessctl} -d intel_backlight set 10%+; ${lib.getExe pkgs.brightnessctl} -d nvidia_0 set 10%+; ${lib.getExe pkgs.libnotify} -a osd -t 1000 -h string:x-dunst-stack-tag:brightness -h int:value:$(${lib.getExe pkgs.brightnessctl} -d intel_backlight -m | cut -d, -f4 | tr -d '%') 'Display Brightness'"
        ];

        bindl = [
          ",switch:on:Lid Switch, exec, if [[ $(${pkgs.supergfxctl}/bin/supergfxctl -g) == 'AsusMuxDgpu' ]] && [[ $(hyprctl monitors -j | ${lib.getExe pkgs.jq} 'length') -gt 1 ]]; then hyprctl keyword monitor 'eDP-1, disable'; fi"
          ",switch:off:Lid Switch, exec, if [[ $(${pkgs.supergfxctl}/bin/supergfxctl -g) == 'AsusMuxDgpu' ]]; then hyprctl keyword monitor 'eDP-1, 2560x1600@240, 0x0, 1.25, vrr, 1, bitdepth, 10'; fi"
        ];
      };

      services.hypridle.settings.listener = [
        {
          timeout = 180;
          on-timeout = "${lib.getExe pkgs.brightnessctl} -d intel_backlight -s set $(( $(${lib.getExe pkgs.brightnessctl} -d intel_backlight -m | cut -d, -f4 | tr -d '%') < 10 ? $(${lib.getExe pkgs.brightnessctl} -d intel_backlight -m | cut -d, -f4 | tr -d '%') : 10 ))%; ${lib.getExe pkgs.brightnessctl} -d nvidia_0 -s set 0%";
          on-resume = "${lib.getExe pkgs.brightnessctl} -d intel_backlight -r; ${lib.getExe pkgs.brightnessctl} -d nvidia_0 -r";
        }
      ];

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
