{
  flake.nixosModules.astraeus = {
    users = {
      users.mewski = {
        isNormalUser = true;
        description = "Mewski";
        initialPassword = "mewski";
        extraGroups = [
          "wheel"
        ];
      };
    };
  };
}
