{ inputs, settings, ... }:

{
  imports = [
    ../../hosts/${settings.system.host}
    ../../modules/nixos/system/kernel.nix
    ../../modules/nixos/system/pipewire.nix
    ../../modules/nixos/system/time.nix
    ../../modules/nixos/window-manager/hyprland.nix
  ];

  # Configure the time zone
  time.timeZone = settings.system.timezone;

  # Configure the locale
  i18n.defaultLocale = settings.system.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = settings.system.locale;
    LC_IDENTIFICATION = settings.system.locale;
    LC_MEASUREMENT = settings.system.locale;
    LC_MONETARY = settings.system.locale;
    LC_NAME = settings.system.locale;
    LC_NUMERIC = settings.system.locale;
    LC_PAPER = settings.system.locale;
    LC_TELEPHONE = settings.system.locale;
    LC_TIME = settings.system.locale;
  };

  # Enable flakes
  nix.settings.experimentalFeatures = [
    "nix-command"
    "flakes"
  ];

  # Configure networking
  networking.hostName = settings.system.hostname;
  networking.networkmanager.enable = true;

  # Configure user account
  users.users.${settings.user.username} = {
    isNormalUser = true;
    description = settings.user.name;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # System state version for defaults
  system.stateVersion = "25.05";
}
