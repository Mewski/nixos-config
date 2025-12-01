{
  flake.homeModules.bitwarden =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        bitwarden-desktop
      ];

      persist.directories = [
        ".config/Bitwarden"
      ];
    };
}
