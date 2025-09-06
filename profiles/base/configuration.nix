{
  inputs,
  settings,
  pkgs,
  ...
}:

{
  imports = [
    # Host-specific configuration
    ../../hosts/${settings.system.host}

    # Core system modules
    ../../modules/nixos/system/kernel.nix
    ../../modules/nixos/system/pipewire.nix
    ../../modules/nixos/system/time.nix

    # Window manager
    ../../modules/nixos/window-manager/hyprland.nix
  ];

  # Configure the time zone
  time.timeZone = settings.system.timezone;

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

  # Enable experimental Nix features
  nix.settings.experimental-features = [
    "nix-command" # New nix CLI commands
    "flakes" # Flake-based package management
  ];

  # Enable unfree packages
  nixpkgs.config.allowUnfree = true;

  # Configure networking
  networking.hostName = settings.system.hostname;
  networking.networkmanager.enable = true; # Enable NetworkManager for WiFi/network management

  # System packages
  environment.systemPackages = with pkgs; [ ];

  # Configure primary user account
  users.users.${settings.user.username} = {
    isNormalUser = true;
    description = settings.user.name;
    extraGroups = [
      "networkmanager" # Allow network configuration
      "wheel" # Enable sudo access
    ];
  };

  # System state version for defaults
  system.stateVersion = "25.05";
}
