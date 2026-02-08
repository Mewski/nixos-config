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
      };

      zramSwap.enable = true;

      services = {
        openssh.enable = true;
        blueman.enable = true;
        resolved.enable = true;
        udev.packages = [ pkgs.wooting-udev-rules ];
      };

      environment.systemPackages = with pkgs; [
        openvpn
        sbctl
      ];

      system.stateVersion = "25.11";
    };

  flake.homeModules.zephyrus =
    { lib, pkgs, ... }:
    let
      brightnessctl = lib.getExe pkgs.brightnessctl;
      notify = lib.getExe pkgs.libnotify;

      kbdBacklight = "asus::kbd_backlight";
      intelBacklight = "intel_backlight";
      nvidiaBacklight = "nvidia_0";
      internalDisplayConfig = "eDP-1, 2560x1600@240, 0x0, 1.25, vrr, 1, bitdepth, 10";

      getKbdBrightness = "${brightnessctl} -d ${kbdBacklight} -m | cut -d, -f4 | tr -d '%'";

      notifyKbdBrightness = pkgs.writeShellScript "notify-kbd-brightness" ''
        ${notify} -a osd -t 1000 \
          -h string:x-dunst-stack-tag:kbd \
          -h int:value:$(${getKbdBrightness}) \
          'Keyboard Brightness'
      '';

      setDisplayBrightness =
        direction:
        pkgs.writeShellScript "set-display-brightness-${direction}" ''
          if [ -d "/sys/class/backlight/${nvidiaBacklight}" ]; then
            val=$(${brightnessctl} -d ${nvidiaBacklight} -m set 5%${direction} | cut -d, -f4 | tr -d '%')
          fi

          if [ -d "/sys/class/backlight/${intelBacklight}" ]; then
            val=$(${brightnessctl} -d ${intelBacklight} -m set 5%${direction} | cut -d, -f4 | tr -d '%')
          fi

          ${notify} -a osd -t 1000 \
            -h string:x-dunst-stack-tag:brightness \
            -h int:value:''${val:-0} \
            'Display Brightness'
        '';

      dimDisplay = pkgs.writeShellScript "dim-display" ''
        ${brightnessctl} -d ${intelBacklight} -s set 1%
        ${brightnessctl} -d ${nvidiaBacklight} -s set 1%
      '';

      restoreDisplay = pkgs.writeShellScript "restore-display" ''
        ${brightnessctl} -d ${intelBacklight} -r
        ${brightnessctl} -d ${nvidiaBacklight} -r
      '';
    in
    {
      wayland.windowManager.hyprland.settings = {
        monitor = [
          internalDisplayConfig
          "DP-1, 2560x1600@144, 2048x0, 1.25"
          "HDMI-A-1, 3840x2160@60, -512x-1728, 1.25"
          ", highrr, auto, 1.25"
        ];

        workspace = [
          "1, monitor:eDP-1, default:true"
          "2, monitor:eDP-1"
          "3, monitor:eDP-1"
          "4, monitor:eDP-1"
          "5, monitor:eDP-1"
          "6, monitor:DP-1, default:true"
          "7, monitor:DP-1"
          "8, monitor:HDMI-A-1, default:true"
          "9, monitor:HDMI-A-1"
          "10, monitor:HDMI-A-1"
        ];

        input.touchpad = {
          clickfinger_behavior = true;
          disable_while_typing = true;
          natural_scroll = true;
          scroll_factor = 0.25;
        };

        device = {
          name = "asup1207:00-093a:3012-touchpad";
          sensitivity = 0.25;
        };

        bindel = [
          ",XF86KbdBrightnessDown, exec, ${brightnessctl} -d ${kbdBacklight} set 1- && ${notifyKbdBrightness}"
          ",XF86KbdBrightnessUp, exec, ${brightnessctl} -d ${kbdBacklight} set 1+ && ${notifyKbdBrightness}"
          ",XF86MonBrightnessDown, exec, ${setDisplayBrightness "-"}"
          ",XF86MonBrightnessUp, exec, ${setDisplayBrightness "+"}"
        ];
      };

      services.hypridle.settings.listener = [
        {
          timeout = 180;
          on-timeout = "${dimDisplay}";
          on-resume = "${restoreDisplay}";
        }
      ];

      home.packages = [ pkgs.wootility ];
    };
}
