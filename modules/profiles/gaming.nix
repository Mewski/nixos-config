{ self, ... }:
{
  flake.nixosModules.gaming = {
    imports = [ self.nixosModules.flatpak ];

    services.flatpak.packages = [
      "org.vinegarhq.Sober"
    ];
  };

  flake.homeModules.gaming =
    { pkgs, ... }:
    {
      imports = [ self.homeModules.flatpak ];

      home.packages = with pkgs; [
        (prismlauncher.override {
          jdks = [
            graalvmPackages.graalvm-ce
          ];
        })
      ];
    };
}
