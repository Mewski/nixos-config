{ ... }:

{
  # Enable chrony time synchronization (preferred over ntpd for modern systems)
  services.chrony.enable = true;
}
