{ inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  # Privacy-focused Firefox-based browser with Zen modifications
  programs.zen-browser = {
    enable = true;

    # Enterprise policies for enhanced privacy and security
    policies = {
      # Disable autofill features for privacy
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;

      # Disable automatic updates and data collection
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;

      # Browser behavior preferences
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;

      # Enhanced tracking protection settings
      EnableTrackingProtection = {
        Cryptomining = true;
        Fingerprinting = true;
        Locked = true;
        Value = true;
      };
    };

    # Browser profile configuration
    profiles.default.settings = {
      # Browser appearance and behavior
      "browser.tabs.allow_transparent_browser" = true;
      "mousewheel.default.delta_multiplier_y" = 100;

      # Hardware acceleration settings
      "gfx.canvas.accelerated" = true;
      "gfx.canvas.accelerated.cache-items" = 32768;
      "gfx.canvas.accelerated.cache-size" = 512;
      "gfx.content.skia-font-cache-size" = 80;
      "gfx.webrender.all" = true;

      # Graphics layer optimization
      "layers.acceleration.force-enabled" = true;
      "layers.omtp.enabled" = true;

      # Media hardware decoding
      "media.ffmpeg.vaapi.enabled" = true;
      "media.hardware-video-decoding.enabled" = true;
      "media.hardware-video-decoding.force-enabled" = true;
      "media.navigator.mediadatadecoder_vpx_enabled" = true;
      "media.rdd-vpx.enabled" = false;

      # Wayland-specific optimizations
      "widget.wayland.fractional-scale.enabled" = true;

      # Zen-specific theme configuration
      "zen.theme.content-element-separation" = 0;
      "zen.widget.linux.transparency" = true;
    };
  };
}
