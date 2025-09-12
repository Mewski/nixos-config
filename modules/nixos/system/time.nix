{ settings, ... }:

{
  time.timeZone = settings.system.timezone;

  # Chrony is preferred over ntpd for better handling of intermittent connections
  services.chrony.enable = true;
}
