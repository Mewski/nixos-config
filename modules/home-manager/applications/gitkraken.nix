{ pkgs, ... }:

{
  # Git GUI client with advanced repository management features
  home.packages = with pkgs; [
    gitkraken
  ];
}
