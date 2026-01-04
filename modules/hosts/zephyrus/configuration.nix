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
        self.nixosModules.nvidia
        self.nixosModules.desktop
        self.nixosModules.development
        self.nixosModules.gaming
      ];

      boot = {
        kernelPackages = pkgs.linuxPackages_testing;

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
        firewall.enable = true;
      };

      services = {
        openssh.enable = true;
        blueman.enable = true;
        udev.packages = [ pkgs.wooting-udev-rules ];
      };

      environment.systemPackages = [ pkgs.sbctl ];

      system.stateVersion = "25.11";
    };

  flake.homeModules.zephyrus =
    { lib, pkgs, ... }:
    let
      brightnessctl = lib.getExe pkgs.brightnessctl;
      notify = lib.getExe pkgs.libnotify;
      jq = lib.getExe pkgs.jq;

      kbdBacklight = "asus::kbd_backlight";
      intelBacklight = "intel_backlight";
      nvidiaBacklight = "nvidia_0";
      internalDisplayConfig = "eDP-1, 2560x1600@240, 0x0, 1.25, vrr, 0, bitdepth, 10";

      getKbdBrightness = "${brightnessctl} -d ${kbdBacklight} -m | cut -d, -f4 | tr -d '%'";
      getDisplayBrightness = "${brightnessctl} -d ${intelBacklight} -m | cut -d, -f4 | tr -d '%'";

      notifyKbdBrightness = pkgs.writeShellScript "notify-kbd-brightness" ''
        ${notify} -a osd -t 1000 \
          -h string:x-dunst-stack-tag:kbd \
          -h int:value:$(${getKbdBrightness}) \
          'Keyboard Brightness'
      '';

      setDisplayBrightness =
        direction:
        pkgs.writeShellScript "set-display-brightness-${direction}" ''
          ${brightnessctl} -d ${nvidiaBacklight} -q set 5%${direction} &
          val=$(${brightnessctl} -d ${intelBacklight} -m set 5%${direction} | cut -d, -f4 | tr -d '%')
          ${notify} -a osd -t 1000 \
            -h string:x-dunst-stack-tag:brightness \
            -h int:value:$val \
            'Display Brightness' &
        '';

      lidSwitchOn = pkgs.writeShellScript "lid-switch-on" ''
        external_connected=$(hyprctl monitors -j | ${jq} '[.[] | select(.name != "eDP-1")] | length > 0')
        if [[ "$external_connected" == "true" ]]; then
          hyprctl keyword monitor 'eDP-1, disable'
        fi
      '';

      lidSwitchOff = pkgs.writeShellScript "lid-switch-off" ''
        is_disabled=$(hyprctl monitors -j | ${jq} '[.[] | select(.name == "eDP-1")] | length == 0')
        if [[ "$is_disabled" == "true" ]]; then
          hyprctl keyword monitor '${internalDisplayConfig}'
        fi
      '';

      dimDisplay = pkgs.writeShellScript "dim-display" ''
        current=$(${getDisplayBrightness})
        ${brightnessctl} -d ${intelBacklight} -s set 1%
        ${brightnessctl} -d ${nvidiaBacklight} -s set 1%
      '';

      restoreDisplay = pkgs.writeShellScript "restore-display" ''
        ${brightnessctl} -d ${intelBacklight} -r
        ${brightnessctl} -d ${nvidiaBacklight} -r
      '';
    in
    {
      imports = [
        self.homeModules.desktop
        self.homeModules.development
        self.homeModules.gaming
      ];

      wayland.windowManager.hyprland.settings = {
        monitor = [
          internalDisplayConfig
          ", preferred, auto, 1"
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

        bindl = [
          ",switch:on:Lid Switch, exec, ${lidSwitchOn}"
          ",switch:off:Lid Switch, exec, ${lidSwitchOff}"
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
