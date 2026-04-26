{ self, ... }:
{
  flake.nixosModules.gaming = {
    imports = [
      self.nixosModules.flatpak
      self.nixosModules.sober
      self.nixosModules.steam
    ];

    home-manager.sharedModules = [ self.homeModules.gaming ];
  };

  flake.homeModules.gaming =
    { pkgs, ... }:
    {
      imports = [
        self.homeModules.flatpak
        self.homeModules.osu
        self.homeModules.prism-launcher
      ];

      home.packages = with pkgs; [
        mangohud
      ];
    };
}
