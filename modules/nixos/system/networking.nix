{ settings, ... }:

{
  # Set system hostname from centralized settings
  networking.hostName = settings.system.hostname;

  # Enable NetworkManager for WiFi and network management
  networking.networkmanager.enable = true;
}
