{ inputs, ... }:
{
  flake.nixosModules.flatpak = {
    imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

    services.flatpak.enable = true;
  };

  flake.homeModules.flatpak = {
    xdg.systemDirs.data = [
      "/var/lib/flatpak/exports/share"
      "$HOME/.local/share/flatpak/exports/share"
    ];
  };
}
