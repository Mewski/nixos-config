{ settings, ... }:

{
  users.users.${settings.user.username} = {
    isNormalUser = true;
    description = settings.user.name;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
