{
  flake.nixosModules.zephyrus =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      hyprctl = lib.getExe' pkgs.hyprland "hyprctl";
      setRefreshRate =
        rate:
        pkgs.writeShellScript "set-refresh-rate" ''
          USER="${config.preferences.user.username}"
          USER_ID=$(${lib.getExe' pkgs.coreutils "id"} -u "$USER")
          XDG_RUNTIME_DIR="/run/user/$USER_ID"

          for socket in "$XDG_RUNTIME_DIR"/hypr/*/.socket.sock; do
            if [ -S "$socket" ]; then
              INSTANCE="$(${lib.getExe' pkgs.coreutils "basename"} "$(${lib.getExe' pkgs.coreutils "dirname"} "$socket")")"
              /run/wrappers/bin/su - "$USER" -c "export XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR HYPRLAND_INSTANCE_SIGNATURE=$INSTANCE; ${hyprctl} keyword monitor 'eDP-1, 2560x1600@${toString rate}, 0x0, 1.25, vrr, 1, bitdepth, 10'; ${hyprctl} setenv INTERNAL_DISPLAY_REFRESH_RATE ${toString rate}"
            fi
          done
        '';
    in
    {
      services.asusd = {
        enable = true;
        enableUserService = true;

        auraConfigs."19b6".text = ''
          (
            config_name: "aura_19b6.ron",
            brightness: Med,
            current_mode: Static,
            builtins: {
              Static: (
                mode: Static,
                zone: r#None,
                colour1: (
                  r: 255,
                  g: 255,
                  b: 255,
                ),
                colour2: (
                  r: 255,
                  g: 255,
                  b: 255,
                ),
                speed: Med,
                direction: Right,
              ),
              Breathe: (
                mode: Breathe,
                zone: r#None,
                colour1: (
                  r: 255,
                  g: 255,
                  b: 255,
                ),
                colour2: (
                  r: 255,
                  g: 255,
                  b: 255,
                ),
                speed: Med,
                direction: Right,
              ),
              RainbowCycle: (
                mode: RainbowCycle,
                zone: r#None,
                colour1: (
                  r: 255,
                  g: 255,
                  b: 255,
                ),
                colour2: (
                  r: 255,
                  g: 255,
                  b: 255,
                ),
                speed: Med,
                direction: Right,
              ),
              RainbowWave: (
                mode: RainbowWave,
                zone: r#None,
                colour1: (
                  r: 255,
                  g: 255,
                  b: 255,
                ),
                colour2: (
                  r: 255,
                  g: 255,
                  b: 255,
                ),
                speed: Med,
                direction: Right,
              ),
              Pulse: (
                mode: Pulse,
                zone: r#None,
                colour1: (
                  r: 255,
                  g: 255,
                  b: 255,
                ),
                colour2: (
                  r: 255,
                  g: 255,
                  b: 255,
                ),
                speed: Med,
                direction: Right,
              ),
            },
            multizone_on: false,
            enabled: (
              states: [
                (
                  zone: Keyboard,
                  boot: true,
                  awake: true,
                  sleep: true,
                  shutdown: true,
                ),
              ],
            ),
          )
        '';

        asusdConfig.text = ''
          (
            charge_control_end_threshold: 100,
            disable_nvidia_powerd_on_battery: true,
            ac_command: "${setRefreshRate 240}",
            bat_command: "${setRefreshRate 60}",
            platform_profile_linked_epp: true,
            platform_profile_on_battery: Quiet,
            change_platform_profile_on_battery: true,
            platform_profile_on_ac: Performance,
            change_platform_profile_on_ac: true,
            profile_quiet_epp: Power,
            profile_balanced_epp: Power,
            profile_custom_epp: Performance,
            profile_performance_epp: Performance,
            ac_profile_tunings: {},
            dc_profile_tunings: {},
            armoury_settings: {},
          )
        '';
      };

      environment.etc."asusd/slash.ron" = {
        mode = "0644";
        text = ''
          (
            enabled: false,
            brightness: 255,
            display_interval: 0,
            display_mode: Bounce,
            show_on_boot: false,
            show_on_shutdown: false,
            show_on_sleep: false,
            show_on_battery: false,
            show_battery_warning: false,
            show_on_lid_closed: false,
          )
        '';
      };
    };
}
