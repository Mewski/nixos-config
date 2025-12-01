{ ... }:
{
  flake.homeModules.gemini-cli =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        gemini-cli
      ];

      persist.directories = [
        ".gemini"
      ];
    };
}
