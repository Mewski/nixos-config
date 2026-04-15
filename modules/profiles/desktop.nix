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
        self.nixosModules.locale
        self.nixosModules.nix
        self.nixosModules.options
        self.nixosModules.pipewire
        self.nixosModules.qt
      ];

      home-manager.sharedModules = [ self.homeModules.desktop ];

      hardware = {
        enableAllFirmware = true;

        bluetooth = {
          enable = true;
          powerOnBoot = true;
          settings = {
            General = {
              Enable = "Source,Sink,Media,Socket";
              Experimental = true;
            };
          };
        };

        graphics = {
          enable = true;
          enable32Bit = true;
        };
      };

      security.polkit.enable = true;

      services = {
        printing.enable = true;
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
        self.homeModules.fish
        self.homeModules.gtk
        self.homeModules.hyprland
        self.homeModules.hyprlock
        self.homeModules.kitty
        self.homeModules.mpv
        self.homeModules.nixcord
        self.homeModules.obsidian
        self.homeModules.qt
        self.homeModules.rofi
        self.homeModules.starship
        self.homeModules.zen-browser
      ];

      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "application/zip" = "org.gnome.FileRoller.desktop";
          "application/x-7z-compressed" = "org.gnome.FileRoller.desktop";
          "application/x-tar" = "org.gnome.FileRoller.desktop";
          "application/gzip" = "org.gnome.FileRoller.desktop";
          "application/x-compressed-tar" = "org.gnome.FileRoller.desktop";
          "application/x-bzip2-compressed-tar" = "org.gnome.FileRoller.desktop";
          "application/x-xz-compressed-tar" = "org.gnome.FileRoller.desktop";
          "application/x-rar" = "org.gnome.FileRoller.desktop";
        };
      };

      home.pointerCursor = {
        inherit (theme.cursor) name package size;
        x11.enable = true;
        gtk.enable = true;
      };

      services.ssh-agent.enable = true;

      home.packages = with pkgs; [
        bitwarden-desktop
        brightnessctl
        davinci-resolve
        drawing
        file
        file-roller
        gimp
        gnome-text-editor
        inkscape
        jq
        libreoffice
        libnotify
        microfetch
        networkmanagerapplet
        obs-studio
        p7zip
        pavucontrol
        playerctl
        qimgv
        signal-desktop
        sops
        spotify
        unzip
        wget
        wlogout
        xxd
      ];
    };
}
