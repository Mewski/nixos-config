{
  flake.nixosModules.preferences = {
    options.preferences = {
      user = {
        name = "Mewski";
        username = "mewski";
      };
    };
  };
}
