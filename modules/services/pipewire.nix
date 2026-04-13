{
  flake.nixosModules.pipewire = {
    security.rtkit.enable = true;
    hardware.alsa.enablePersistence = true;

    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
      wireplumber = {
        enable = true;
        extraConfig = {
          "11-bluetooth-policy" = {
            "wireplumber.settings" = {
              "bluetooth.autoswitch-to-headset-profile" = false;
            };
          };
          "50-bluez-config" = {
            "monitor.bluez.properties" = {
              "bluez5.enable-sbc-xq" = true;
              "bluez5.enable-msbc" = true;
              "bluez5.enable-hw-volume" = true;
              "bluez5.roles" = [
                "a2dp_sink"
                "a2dp_source"
              ];
            };
            "monitor.bluez.rules" = [
              {
                matches = [
                  { "device.name" = "~bluez_card.*"; }
                ];
                actions = {
                  update-props = {
                    "bluez5.auto-connect" = [
                      "a2dp_sink"
                      "a2dp_source"
                    ];
                  };
                };
              }
            ];
          };
        };
      };
    };
  };
}
