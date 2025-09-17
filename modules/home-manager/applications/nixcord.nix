{ inputs, ... }:

{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  # Discord client with Vencord plugins and themes
  programs.nixcord.enable = true;
}
