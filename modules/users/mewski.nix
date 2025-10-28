{
  flake.nixosModules.mewski = {
    users.users.mewski = {
      description = "Mewski";
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };

  flake.homeModules.mewski = {
    home.username = "mewski";
    home.homeDirectory = "/home/mewski";

    programs.home-manager.enable = true;

    home.stateVersion = "25.11";
  };
}
