{ self, ... }:
{
  flake.nixosModules.desktop = {
    imports = [
      self.nixosModules.preferences
      self.nixosModules.theme
      self.nixosModules.user
      self.nixosModules.home-manager
      self.nixosModules.hyprland
      self.nixosModules.nix
      self.nixosModules.pipewire
      self.nixosModules.fish
      self.nixosModules.virtualization
      self.nixosModules.docker
    ];

    hardware = {
      enableAllFirmware = true;

      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };

      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };

    time.timeZone = "America/Chicago";

    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };
    };

    security.polkit.enable = true;

    services.upower.enable = true;

    services.gnome.gnome-keyring.enable = true;
  };

  flake.homeModules.desktop =
    { pkgs, ... }:
    {
      imports = [
        self.homeModules.theme
        self.homeModules.hyprland
        self.homeModules.waybar
        self.homeModules.fish
        self.homeModules.git
        self.homeModules.kitty
        self.homeModules.nixvim
        self.homeModules.nixcord
        self.homeModules.zed-editor
        self.homeModules.zen-browser
        self.homeModules.yazi
        self.homeModules.btop
        self.homeModules.hypridle
        self.homeModules.hyprlock
        self.homeModules.rofi
        self.homeModules.dunst
      ];

      home.packages = with pkgs; [
        bitwarden-desktop
        wl-clipboard
        cliphist
        unzip
        p7zip
      ];
    };
}
