{ inputs, ... }:
{
  flake.homeModules.zen-browser = {
    imports = [ inputs.zen-browser.homeModules.beta ];

    programs.zen-browser = {
      enable = true;

      policies = {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;

        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };

        ExtensionSettings = {
          "addon@darkreader.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
            installation_mode = "force_installed";
          };
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          "foxyproxy@eric.h.jung" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/foxyproxy-standard/latest.xpi";
            installation_mode = "force_installed";
          };
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
          };
          "{c3c10168-4186-445c-9c5b-63f12b8e2c87}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/cookie-editor/latest.xpi";
            installation_mode = "force_installed";
          };
          "{e10a941c-9e0f-4d1c-93b4-2e5500d87b28}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/tampermonkey/latest.xpi";
            installation_mode = "force_installed";
          };
        };
      };

      profiles.default.settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "zen.theme.content-element-separation" = 0;
        "zen.view.grey-out-inactive-windows" = false;
        "zen.widget.linux.transparency" = true;
        "zen.window-sync.enabled" = false;
      };
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "zen-beta.desktop" ];
      };
    };
  };
}
