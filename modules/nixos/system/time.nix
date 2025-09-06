{ settings, ... }:

{
  # Configure the time zone
  time.timeZone = settings.system.timezone;

  # Enable chrony time synchronization (preferred over ntpd for modern systems)
  services.chrony.enable = true;
}
