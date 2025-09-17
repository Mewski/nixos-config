{ settings, ... }:

{
  # Set system default locale
  i18n.defaultLocale = settings.system.locale;

  # Configure locale settings for different categories
  i18n.extraLocaleSettings = {
    LC_ADDRESS = settings.system.locale;
    LC_IDENTIFICATION = settings.system.locale;
    LC_MEASUREMENT = settings.system.locale;
    LC_MONETARY = settings.system.locale;
    LC_NAME = settings.system.locale;
    LC_NUMERIC = settings.system.locale;
    LC_PAPER = settings.system.locale;
    LC_TELEPHONE = settings.system.locale;
    LC_TIME = settings.system.locale;
  };
}
