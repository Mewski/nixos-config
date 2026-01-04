{ inputs, ... }:
{
  flake.homeModules.nixcord =
    { pkgs, ... }:
    {
      imports = [ inputs.nixcord.homeModules.nixcord ];

      programs.nixcord = {
        enable = true;
        discord = {
          vencord.enable = true;
          package = pkgs.discord.override {
            commandLineArgs = "-- --use-gl=angle --use-angle=opengl --ignore-gpu-blocklist --enable-gpu-rasterization";
          };
        };
      };
    };
}
