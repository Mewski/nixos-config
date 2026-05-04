{
  flake.homeModules.hyprland =
    {
      lib,
      osConfig,
      pkgs,
      ...
    }:
    let
      brightnessctl = lib.getExe pkgs.brightnessctl;
      notify = lib.getExe pkgs.libnotify;
      supergfxctl = lib.getExe' pkgs.supergfxctl "supergfxctl";

      kbdBacklight = "asus::kbd_backlight";
      intelBacklight = "intel_backlight";
      nvidiaBacklight = "nvidia_0";

      activeDisplayBacklight = ''
        backlight=${intelBacklight}
        if [ "$(${supergfxctl} -g 2>/dev/null || true)" = AsusMuxDgpu ] && [ -d "/sys/class/backlight/${nvidiaBacklight}" ]; then
          backlight=${nvidiaBacklight}
        fi
      '';

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
          ${activeDisplayBacklight}
          val=$(${brightnessctl} -d "$backlight" -m set 5%${direction} | cut -d, -f4 | tr -d '%')

          ${notify} -a osd -t 1000 \
            -h string:x-dunst-stack-tag:brightness \
            -h int:value:$val \
            'Display Brightness'
        '';

      dimDisplay = pkgs.writeShellScript "dim-display" ''
        ${activeDisplayBacklight}
        ${brightnessctl} -d "$backlight" -s set 1%
      '';

      restoreDisplay = pkgs.writeShellScript "restore-display" ''
        ${activeDisplayBacklight}
        ${brightnessctl} -d "$backlight" -r
      '';
    in
    lib.mkIf (osConfig.networking.hostName == "zephyrus") {
      wayland.windowManager.hyprland.settings = {
        input.touchpad = {
          clickfinger_behavior = true;
          disable_while_typing = true;
          natural_scroll = true;
          scroll_factor = 0.35;
        };

        device = {
          name = "asup1207:00-093a:3012-touchpad";
          sensitivity = 0.35;
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
    };
}
