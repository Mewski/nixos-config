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
  };
}
