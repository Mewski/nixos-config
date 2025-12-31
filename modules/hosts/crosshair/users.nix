{
  flake.nixosModules.crosshair =
    { config, pkgs, ... }:
    {
      sops.secrets."users/mewski/hashed_password".neededForUsers = true;

      users = {
        mutableUsers = false;
        users.mewski = {
          isNormalUser = true;
          description = "Mewski";
          hashedPasswordFile = config.sops.secrets."users/mewski/hashed_password".path;
          shell = pkgs.fish;
          extraGroups = [
            "networkmanager"
            "wheel"
            "docker"
            "libvirtd"
            "gamemode"
          ];
        };
      };

      home-manager.users.mewski = {
        home = {
          username = "mewski";
          homeDirectory = "/home/mewski";
          stateVersion = "25.11";
        };
        programs.home-manager.enable = true;
      };
    };
}
