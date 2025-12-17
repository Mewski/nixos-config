{ self, ... }:
{
  flake.nixosModules.desktop =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.nix
        self.nixosModules.options
        self.nixosModules.preferences
        self.nixosModules.user

        self.nixosModules.home-manager
        self.nixosModules.hyprland
        self.nixosModules.theme

        self.nixosModules.fish

        self.nixosModules.mullvad-vpn
        self.nixosModules.pipewire
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

      environment.systemPackages = with pkgs; [ nautilus ];
    };

  flake.homeModules.desktop =
    { pkgs, theme, ... }:
    {
      imports = [
        self.homeModules.hyprland
        self.homeModules.theme

        self.homeModules.dunst
        self.homeModules.hyprlock
        self.homeModules.rofi
        self.homeModules.waybar

        self.homeModules.btop
        self.homeModules.fish
        self.homeModules.kitty

        self.homeModules.nixcord
        self.homeModules.obsidian
        self.homeModules.zen-browser
      ];

      home.pointerCursor = {
        inherit (theme.cursor) name package size;
        x11.enable = true;
        gtk.enable = true;
      };

      home.packages = with pkgs; [
        unzip
        p7zip

        wget
        xxd
        jq

        wl-clipboard
        cliphist

        networkmanagerapplet
        pavucontrol
        qimgv

        bitwarden-desktop
        spotify
      ];
    };
}
