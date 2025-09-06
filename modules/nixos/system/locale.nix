{ settings, ... }:

{
  # Configure system locale and regional settings
  i18n.defaultLocale = settings.system.locale;

  # Set all locale categories to the same locale for consistency
  i18n.extraLocaleSettings = {
    LC_ADDRESS = settings.system.locale; # Address formatting
    LC_IDENTIFICATION = settings.system.locale; # Personal name formatting
    LC_MEASUREMENT = settings.system.locale; # Measurement units (metric/imperial)
    LC_MONETARY = settings.system.locale; # Currency formatting
    LC_NAME = settings.system.locale; # Name formatting conventions
    LC_NUMERIC = settings.system.locale; # Number formatting (decimal separator, etc.)
    LC_PAPER = settings.system.locale; # Paper size (A4, Letter, etc.)
    LC_TELEPHONE = settings.system.locale; # Telephone number formatting
    LC_TIME = settings.system.locale; # Date and time formatting
  };
}
