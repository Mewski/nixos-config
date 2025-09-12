{ settings, ... }:

{
  networking.hostName = settings.system.hostname;
  networking.networkmanager.enable = true;
}
