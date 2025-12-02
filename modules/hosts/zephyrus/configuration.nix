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
    let
      brightnessctl = lib.getExe pkgs.brightnessctl;
      notify = lib.getExe pkgs.libnotify;
      jq = lib.getExe pkgs.jq;
      supergfxctl = "${pkgs.supergfxctl}/bin/supergfxctl";

      kbdBacklight = "asus::kbd_backlight";
      intelBacklight = "intel_backlight";
      nvidiaBacklight = "nvidia_0";

      monitorConfig = "eDP-1, 2560x1600@240, 0x0, 1.25, vrr, 1, bitdepth, 10";

      getKbdBrightness = "${brightnessctl} -d ${kbdBacklight} -m | cut -d, -f4 | tr -d '%'";
      getDisplayBrightness = "${brightnessctl} -d ${intelBacklight} -m | cut -d, -f4 | tr -d '%'";

      notifyKbdBrightness = pkgs.writeShellScript "notify-kbd-brightness" ''
        ${notify} -a osd -t 1000 \
          -h string:x-dunst-stack-tag:kbd \
          -h int:value:$(${getKbdBrightness}) \
          'Keyboard Brightness'
      '';

      notifyDisplayBrightness = pkgs.writeShellScript "notify-display-brightness" ''
        ${notify} -a osd -t 1000 \
          -h string:x-dunst-stack-tag:brightness \
          -h int:value:$(${getDisplayBrightness}) \
          'Display Brightness'
      '';

      lidSwitchOn = pkgs.writeShellScript "lid-switch-on" ''
        if [[ $(${supergfxctl} -g) == 'AsusMuxDgpu' ]] && \
           [[ $(hyprctl monitors -j | ${jq} 'length') -gt 1 ]]; then
          hyprctl keyword monitor 'eDP-1, disable'
        fi
      '';

      lidSwitchOff = pkgs.writeShellScript "lid-switch-off" ''
        if [[ $(${supergfxctl} -g) == 'AsusMuxDgpu' ]]; then
          hyprctl keyword monitor '${monitorConfig}'
        fi
      '';

      dimDisplay = pkgs.writeShellScript "dim-display" ''
        current=$(${getDisplayBrightness})
        target=$((current < 10 ? current : 10))
        ${brightnessctl} -d ${intelBacklight} -s set ''${target}%
        ${brightnessctl} -d ${nvidiaBacklight} -s set 0%
      '';

      restoreDisplay = pkgs.writeShellScript "restore-display" ''
        ${brightnessctl} -d ${intelBacklight} -r
        ${brightnessctl} -d ${nvidiaBacklight} -r
      '';
    in
    {
      imports = [ self.homeModules.desktop ];

      wayland.windowManager.hyprland.settings = {
        monitor = [ "${monitorConfig}" ];

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
          ",XF86KbdBrightnessDown, exec, ${brightnessctl} -d ${kbdBacklight} set 1- && ${notifyKbdBrightness}"
          ",XF86KbdBrightnessUp, exec, ${brightnessctl} -d ${kbdBacklight} set 1+ && ${notifyKbdBrightness}"

          ",XF86MonBrightnessDown, exec, ${brightnessctl} -d ${intelBacklight} set 10%-; ${brightnessctl} -d ${nvidiaBacklight} set 10%-; ${notifyDisplayBrightness}"
          ",XF86MonBrightnessUp, exec, ${brightnessctl} -d ${intelBacklight} set 10%+; ${brightnessctl} -d ${nvidiaBacklight} set 10%+; ${notifyDisplayBrightness}"
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

      home.packages = with pkgs; [
        bitwarden-desktop
      ];
    };
}
