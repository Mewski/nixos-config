{
  flake.homeModules.niri =
    { scheme, ... }:
    {
      programs.swaylock.settings = {
        color = scheme.base00;
        inside-color = scheme.base00;
        ring-color = scheme.base03;
        text-color = scheme.base05;
      };
    };
}
