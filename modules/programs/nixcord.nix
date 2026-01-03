{ inputs, ... }:
{
  flake.homeModules.nixcord =
    { pkgs, ... }:
    {
      imports = [ inputs.nixcord.homeModules.nixcord ];

      programs.nixcord = {
        enable = true;
        discord.package = inputs.nixcord.packages.${pkgs.system}.discord.override {
          commandLineArgs = "--enable-gpu-rasterization";
        };
      };
    };
}
