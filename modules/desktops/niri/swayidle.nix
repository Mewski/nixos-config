{
  flake.homeModules.niri =
    { lib, pkgs, ... }:
    {
      services.swayidle = {
        enable = true;
        events = [
          {
            event = "before-sleep";
            command = "${lib.getExe pkgs.swaylock} -f";
          }
        ];
        timeouts = [ ];
      };
    };
}
