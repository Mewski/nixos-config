{ self, ... }:
{
  flake.nixosModules.gaming = {
    imports = [ self.nixosModules.flatpak ];

    programs.steam.enable = true;

    programs.gamemode.enable = true;

    services.flatpak.packages = [
      "org.vinegarhq.Sober"
    ];
  };

  flake.homeModules.gaming =
    { pkgs, ... }:
    {
      imports = [ self.homeModules.flatpak ];

      home.packages = [
        (pkgs.prismlauncher.override {
          jdks = [
            pkgs.graalvmPackages.graalvm-ce
          ];
        })
      ];
    };
}
