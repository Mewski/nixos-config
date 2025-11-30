{ self, ... }:
{
  flake.nixosModules.desktop = {
    imports = [
      self.nixosModules.nix
      self.nixosModules.user
      self.nixosModules.home-manager
      self.nixosModules.preferences

      self.nixosModules.hyprland
      self.nixosModules.theme
      self.nixosModules.pipewire

      self.nixosModules.fish

      self.nixosModules.docker
      self.nixosModules.virtualization
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
        self.homeModules.hyprland
        self.homeModules.hypridle
        self.homeModules.hyprlock
        self.homeModules.waybar
        self.homeModules.rofi
        self.homeModules.dunst
        self.homeModules.theme

        self.homeModules.fish
        self.homeModules.git
        self.homeModules.kitty
        self.homeModules.yazi
        self.homeModules.btop

        self.homeModules.nixvim
        self.homeModules.zed-editor
        self.homeModules.claude-code

        self.homeModules.zen-browser
        self.homeModules.nixcord
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
