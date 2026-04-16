{
  flake.homeModules.niri = {
    programs.niri.settings = {
      animations = { };
      prefer-no-csd = true;
    };
  };
}
