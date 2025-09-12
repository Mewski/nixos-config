{ settings, ... }:

{
  # Configure primary user account
  users.users.${settings.user.username} = {
    isNormalUser = true;
    description = settings.user.name;
    extraGroups = [
      "networkmanager" # Network configuration access
      "wheel" # Sudo access
    ];
  };
}
