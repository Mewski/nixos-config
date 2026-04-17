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

      kbdBacklight = "asus::kbd_backlight";
      intelBacklight = "intel_backlight";
      nvidiaBacklight = "nvidia_0";

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
    lib.mkIf (osConfig.networking.hostName == "zephyrus") {
      wayland.windowManager.hyprland.settings = {
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
    };
}
