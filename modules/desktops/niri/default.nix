{ inputs, self, ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      imports = [ inputs.niri.nixosModules.niri ];

      nixpkgs.overlays = [ inputs.niri.overlays.niri ];
      programs.niri.enable = true;
      programs.niri.package = pkgs.niri-unstable;
      security.pam.services.swaylock = { };
      desktop.session.command = "niri-session";

      home-manager.sharedModules = [ self.homeModules.niri ];

      environment = {
        sessionVariables.NIXOS_OZONE_WL = "1";
        systemPackages = with pkgs; [
          kdePackages.qtwayland
          libsForQt5.qtwayland
          xwayland-satellite
        ];
      };
    };

  flake.homeModules.niri =
    {
      lib,
      pkgs,
      theme,
      ...
    }:
    {
      programs.niri = {
        settings = {
          prefer-no-csd = true;
          screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
          hotkey-overlay = {
            skip-at-startup = true;
            hide-not-bound = true;
          };
          clipboard.disable-primary = true;
          environment = {
            ELECTRON_OZONE_PLATFORM_HINT = "auto";
            KDE_SESSION_VERSION = "6";
            NIXOS_OZONE_WL = "1";
            QT_QPA_PLATFORMTHEME = "qt6ct";
            QT_STYLE_OVERRIDE = "kvantum";
          };
          cursor = {
            theme = theme.cursor.name;
            inherit (theme.cursor) size;
          };
          spawn-at-startup = [
            {
              argv = [
                (lib.getExe' pkgs.wl-clipboard "wl-paste")
                "--type"
                "text"
                "--watch"
                (lib.getExe pkgs.cliphist)
                "store"
              ];
            }
            {
              argv = [
                (lib.getExe' pkgs.wl-clipboard "wl-paste")
                "--type"
                "image"
                "--watch"
                (lib.getExe pkgs.cliphist)
                "store"
              ];
            }
          ];
        };
      };

      xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        config.common.default = "*";
      };

      xdg.configFile."electron-flags.conf".text = ''
        --enable-features=UseOzonePlatform,WaylandWindowDecorations
        --ozone-platform-hint=auto
      '';

      home.packages = with pkgs; [
        cliphist
        grim
        slurp
        tesseract
        wl-clipboard
      ];
    };
}
