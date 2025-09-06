{ settings, ... }:

{
  # Configure networking
  networking.hostName = settings.system.hostname;
  networking.networkmanager.enable = true; # Enable NetworkManager for WiFi/network management
}
