{
  flake.homeModules.niri =
    {
      config,
      lib,
      osConfig,
      pkgs,
      ...
    }:
    let
      brightnessctl = lib.getExe pkgs.brightnessctl;
      notify = lib.getExe pkgs.libnotify;
      notifyOsd = "${lib.getExe' pkgs.coreutils "timeout"} 0.2s ${notify}";
      supergfxctl = lib.getExe' pkgs.supergfxctl "supergfxctl";
      niri = lib.getExe config.programs.niri.package;
      swayidle = lib.getExe pkgs.swayidle;
      swaylock = lib.getExe pkgs.swaylock;

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
        ${notifyOsd} -a osd -t 1000 \
          -h string:x-dunst-stack-tag:kbd \
          -h int:value:$(${getKbdBrightness}) \
          'Keyboard Brightness'
      '';

      setDisplayBrightness =
        direction:
        pkgs.writeShellScript "set-display-brightness-${direction}" ''
          ${activeDisplayBacklight}
          val=$(${brightnessctl} -d "$backlight" -m set 5%${direction} | cut -d, -f4 | tr -d '%')

          ${notifyOsd} -a osd -t 1000 \
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
      programs.niri.settings = {
        input.touchpad = {
          click-method = "clickfinger";
          dwt = true;
          natural-scroll = true;
          scroll-factor = 0.35;
        };

        binds = {
          "XF86KbdBrightnessDown".action.spawn-sh = "${brightnessctl} -d ${kbdBacklight} set 1- && ${notifyKbdBrightness}";
          "XF86KbdBrightnessUp".action.spawn-sh = "${brightnessctl} -d ${kbdBacklight} set 1+ && ${notifyKbdBrightness}";
          "XF86MonBrightnessDown".action.spawn = [ "${setDisplayBrightness "-"}" ];
          "XF86MonBrightnessUp".action.spawn = [ "${setDisplayBrightness "+"}" ];
        };
      };

      systemd.user.services.swayidle.Service.ExecStart = lib.mkForce ''
        ${swayidle} -w \
          before-sleep 'loginctl lock-session' \
          lock 'pidof swaylock || ${swaylock} --daemonize' \
          timeout 180 '${dimDisplay}' resume '${restoreDisplay}' \
          timeout 195 '${niri} msg action power-off-monitors' resume '${niri} msg action power-on-monitors' \
          timeout 300 'systemctl suspend'
      '';
    };
}
