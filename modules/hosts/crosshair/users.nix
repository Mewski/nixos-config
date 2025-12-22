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
          ];
        };
      };

      home-manager.users.mewski = {
        home.username = "mewski";
        home.homeDirectory = "/home/mewski";

        programs.home-manager.enable = true;

        home.stateVersion = "25.11";
      };
    };
}
