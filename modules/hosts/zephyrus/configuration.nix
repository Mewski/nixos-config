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

        self.nixosModules.virtualization

        self.nixosModules.docker
        self.nixosModules.mullvad-vpn
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

        firewall = {
          enable = true;

          allowedTCPPorts = [ ];

          allowedUDPPorts = [ ];
        };
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

      kbdBacklight = "asus::kbd_backlight";
      intelBacklight = "intel_backlight";
      nvidiaBacklight = "nvidia_0";

      internalDisplayConfig = "eDP-1, 2560x1600@240, 0x0, 1.25, vrr, 1, bitdepth, 10";

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
        external_connected=$(hyprctl monitors -j | ${jq} '[.[] | select(.name != "eDP-1")] | length > 0')
        if [[ "$external_connected" == "true" ]]; then
          for ws in {1..10}; do
            hyprctl dispatch moveworkspacetomonitor "$ws" "$(hyprctl monitors -j | ${jq} -r '[.[] | select(.name != "eDP-1")][0].name')"
          done
          hyprctl keyword monitor 'eDP-1, disable'
        fi
      '';

      lidSwitchOff = pkgs.writeShellScript "lid-switch-off" ''
        is_disabled=$(hyprctl monitors -j | ${jq} '[.[] | select(.name == "eDP-1")] | length == 0')
        if [[ "$is_disabled" == "true" ]]; then
          hyprctl keyword monitor '${internalDisplayConfig}'
          for ws in {1..10}; do
            hyprctl dispatch moveworkspacetomonitor "$ws" "eDP-1"
          done
        fi
      '';

      dimDisplay = pkgs.writeShellScript "dim-display" ''
        current=$(${getDisplayBrightness})
        ${brightnessctl} -d ${intelBacklight} -s set 5%
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
        monitor = [
          "${internalDisplayConfig}"
          ", preferred, auto, 1"
        ];

        workspace = [
          "1, monitor:eDP-1, default:true"
          "2, monitor:eDP-1"
          "3, monitor:eDP-1"
          "4, monitor:eDP-1"
          "5, monitor:eDP-1"
          "6, monitor:eDP-1"
          "7, monitor:eDP-1"
          "8, monitor:eDP-1"
          "9, monitor:eDP-1"
          "10, monitor:eDP-1"
          "11, monitor:HDMI-A-1, default:true"
          "12, monitor:HDMI-A-1"
          "13, monitor:HDMI-A-1"
          "14, monitor:HDMI-A-1"
          "15, monitor:HDMI-A-1"
          "16, monitor:HDMI-A-1"
          "17, monitor:HDMI-A-1"
          "18, monitor:HDMI-A-1"
          "19, monitor:HDMI-A-1"
          "20, monitor:HDMI-A-1"
        ];

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
          sensitivity = 0.25;
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
