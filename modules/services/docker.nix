{
  flake.nixosModules.docker = {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
    };
  };
}
