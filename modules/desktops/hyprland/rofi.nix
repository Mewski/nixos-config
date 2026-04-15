{
  flake.homeModules.rofi = {
    programs.rofi = {
      enable = true;
      extraConfig = {
        show-icons = true;
        display-drun = "";
        drun-display-format = "{name}";
      };
    };
  };
}
