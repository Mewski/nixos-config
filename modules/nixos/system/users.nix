{ settings, ... }:

{
  # Configure primary user account
  users.users.${settings.user.username} = {
    isNormalUser = true;
    description = settings.user.name;
    extraGroups = [
      "networkmanager" # Allow network configuration
      "wheel" # Enable sudo access
    ];
  };
}
