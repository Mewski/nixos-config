{ inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  programs.zen-browser = {
    enable = true;

    # Enterprise policies for privacy and security
    policies = {
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
    };

    # Browser profile configuration
    profiles.default.settings = {
      # Zen-specific theme settings
      "zen.theme.content-element-separation" = 0;
      "zen.widget.linux.transparency" = true;
      "browser.tabs.allow_transparent_browser" = true;

      # Profile-specific settings
      "mousewheel.default.delta_multiplier_y" = 100;

      # Hardware acceleration settings
      "gfx.webrender.all" = true;
      "layers.acceleration.force-enabled" = true;
      "layers.omtp.enabled" = true;
      "media.ffmpeg.vaapi.enabled" = true;
      "media.hardware-video-decoding.enabled" = true;
      "media.hardware-video-decoding.force-enabled" = true;
      "media.navigator.mediadatadecoder_vpx_enabled" = true;
      "media.rdd-vpx.enabled" = false;
      "gfx.canvas.accelerated" = true;
      "gfx.canvas.accelerated.cache-items" = 32768;
      "gfx.canvas.accelerated.cache-size" = 512;
      "gfx.content.skia-font-cache-size" = 80;

      # Wayland-specific preferences
      "widget.wayland.fractional-scale.enabled" = true;
    };
  };
}
