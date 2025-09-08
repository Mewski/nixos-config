{ inputs, ... }:

{
  import = [
    inputs.zen-browser.homeModules.twilight
  ];

  programs.zen-browser.enable = true;
}
