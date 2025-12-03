{ self, ... }:
{
  flake.nixosModules.desktop =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.options
        self.nixosModules.preferences
        self.nixosModules.nix
        self.nixosModules.user
        self.nixosModules.home-manager
        self.nixosModules.hyprland
        self.nixosModules.theme

        self.nixosModules.fish

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
        self.homeModules.theme
        self.homeModules.hyprland
        self.homeModules.hyprlock
        self.homeModules.waybar
        self.homeModules.rofi
        self.homeModules.dunst

        self.homeModules.fish
        self.homeModules.git
        self.homeModules.kitty
        self.homeModules.btop

        self.homeModules.nixvim
        self.homeModules.zed-editor
        self.homeModules.claude-code
        self.homeModules.gemini-cli

        self.homeModules.nixcord
        self.homeModules.zen-browser
      ];

      home.pointerCursor = {
        name = theme.cursor.name;
        package = theme.cursor.package;
        size = theme.cursor.size;
        x11.enable = true;
        gtk.enable = true;
      };

      home.packages = with pkgs; [
        unzip
        p7zip

        wl-clipboard
        cliphist

        networkmanagerapplet
        pavucontrol
      ];
    };
}
