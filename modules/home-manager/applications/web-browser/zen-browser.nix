{ inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  programs.zen-browser = {
    enable = true;

    # Enterprise policies for privacy and security
    policies =
      let
        # Helper function to create locked preference attributes
        mkLockedAttrs = builtins.mapAttrs (
          _: value: {
            Value = value;
            Status = "locked";
          }
        );
      in
      {
        # Disable autofill features
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;

        # Disable automatic updates and telemetry
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;

        # Browser behavior settings
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;

        # Enhanced tracking protection
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };

        # Wayland-specific preferences
        preferences = mkLockedAttrs {
          "widget.wayland.fractional-scale.enabled" = true;
        };
      };

    # Browser profile configuration
    profiles.default.settings = {
      # Zen-specific theme settings
      "zen.theme.content-element-separation" = 0;

      # Profile-specific settings
      "mousewheel.default.delta_multiplier_y" = 100;
    };
  };
}
