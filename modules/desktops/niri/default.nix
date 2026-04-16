{ inputs, self, ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      imports = [ inputs.niri.nixosModules.niri ];

      programs.niri = {
        enable = true;
        package = pkgs.niri;
      };

      home-manager.sharedModules = [ self.homeModules.niri ];

      environment = {
        sessionVariables.NIXOS_OZONE_WL = "1";

        systemPackages = with pkgs; [
          libsForQt5.qtwayland
          kdePackages.qtwayland
        ];
      };
    };

  flake.homeModules.niri =
    { pkgs, ... }:
    {
      imports = [ inputs.niri.homeModules.niri ];

      programs.niri.settings = { };

      services.hyprpolkitagent.enable = true;

      xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      };

      home.packages = with pkgs; [
        cliphist
        wl-clipboard
      ];
    };
}
