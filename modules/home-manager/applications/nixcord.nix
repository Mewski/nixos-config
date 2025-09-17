{ inputs, ... }:

{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  # Discord client with Vencord extensions and theming
  programs.nixcord.enable = true;
}
