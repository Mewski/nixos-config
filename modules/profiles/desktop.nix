{ self, ... }:
{
  flake.nixosModules.desktop =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.fish
        self.nixosModules.gtk
        self.nixosModules.home-manager
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
        self.homeModules.kitty
        self.homeModules.mpv
        self.homeModules.nixcord
        self.homeModules.obsidian
        self.homeModules.qt
        self.homeModules.starship
        self.homeModules.zen-browser
      ];

      xdg.mimeApps = {
        enable = true;
        defaultApplications =
          let
            browser = "zen-beta.desktop";
            fileManager = "org.gnome.Nautilus.desktop";
            imageViewer = "qimgv.desktop";
            videoPlayer = "mpv.desktop";
            textEditor = "org.gnome.TextEditor.desktop";
            archiver = "org.gnome.FileRoller.desktop";
            pdfViewer = "org.gnome.Evince.desktop";
          in
          {
            "x-scheme-handler/http" = browser;
            "x-scheme-handler/https" = browser;
            "x-scheme-handler/chrome" = browser;
            "text/html" = browser;
            "application/xhtml+xml" = browser;

            "application/pdf" = pdfViewer;

            "inode/directory" = fileManager;

            "image/png" = imageViewer;
            "image/jpeg" = imageViewer;
            "image/gif" = imageViewer;
            "image/webp" = imageViewer;
            "image/bmp" = imageViewer;
            "image/tiff" = imageViewer;
            "image/svg+xml" = imageViewer;

            "video/mp4" = videoPlayer;
            "video/x-matroska" = videoPlayer;
            "video/webm" = videoPlayer;
            "video/x-msvideo" = videoPlayer;
            "video/quicktime" = videoPlayer;
            "audio/mpeg" = videoPlayer;
            "audio/flac" = videoPlayer;
            "audio/ogg" = videoPlayer;
            "audio/x-wav" = videoPlayer;

            "text/plain" = textEditor;
            "text/x-csrc" = textEditor;
            "text/x-chdr" = textEditor;
            "text/x-python" = textEditor;
            "text/x-shellscript" = textEditor;
            "text/markdown" = textEditor;
            "application/json" = textEditor;
            "application/xml" = textEditor;
            "application/x-yaml" = textEditor;

            "application/zip" = archiver;
            "application/x-7z-compressed" = archiver;
            "application/x-tar" = archiver;
            "application/gzip" = archiver;
            "application/x-compressed-tar" = archiver;
            "application/x-bzip2-compressed-tar" = archiver;
            "application/x-xz-compressed-tar" = archiver;
            "application/x-rar" = archiver;
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
        evince
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
