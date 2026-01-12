{ self, ... }:
{
  flake.nixosModules.desktop =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.fish
        self.nixosModules.gtk
        self.nixosModules.home-manager
        self.nixosModules.hyprland
        self.nixosModules.nix
        self.nixosModules.options
        self.nixosModules.pipewire
        self.nixosModules.qt
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

      services = {
        upower.enable = true;
        gnome.gnome-keyring.enable = true;
      };

      environment.systemPackages = [ pkgs.nautilus ];
    };

  flake.homeModules.desktop =
    { pkgs, theme, ... }:
    {
      imports = [
        self.homeModules.btop
        self.homeModules.dunst
        self.homeModules.fish
        self.homeModules.gtk
        self.homeModules.hyprland
        self.homeModules.hyprlock
        self.homeModules.kitty
        self.homeModules.nixcord
        self.homeModules.obsidian
        self.homeModules.qt
        self.homeModules.rofi
        self.homeModules.waybar
        self.homeModules.zen-browser
      ];

      home.pointerCursor = {
        inherit (theme.cursor) name package size;
        x11.enable = true;
        gtk.enable = true;
      };

      services.ssh-agent.enable = true;

      home.packages = with pkgs; [
        bitwarden-desktop
        brightnessctl
        cliphist
        gnome-text-editor
        hyprpicker
        hyprshot
        jq
        libnotify
        microfetch
        mpv
        networkmanagerapplet
        p7zip
        pavucontrol
        playerctl
        qimgv
        spotify
        unzip
        wget
        wl-clipboard
        wlogout
        xxd
      ];
    };
}
