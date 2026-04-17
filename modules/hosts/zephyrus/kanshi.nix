{
  flake.homeModules.zephyrus = {
    services.kanshi = {
      enable = true;
      systemdTarget = "graphical-session.target";
      settings = [
        {
          profile.name = "undocked";
          profile.outputs = [
            {
              criteria = "eDP-1";
              mode = "2560x1600@240Hz";
              position = "0,0";
              scale = 1.25;
            }
          ];
        }
        {
          profile.name = "portable-monitor";
          profile.outputs = [
            {
              criteria = "eDP-1";
              mode = "2560x1600@240Hz";
              position = "0,0";
              scale = 1.25;
            }
            {
              criteria = "Genesys ATE Inc PM160K1-H";
              mode = "2560x1600@144Hz";
              position = "2048,0";
              scale = 1.25;
            }
          ];
        }
      ];
    };
  };
}
