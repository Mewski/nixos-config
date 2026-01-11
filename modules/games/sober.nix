{
  flake.nixosModules.sober = {
    services.flatpak.packages = [ "org.vinegarhq.Sober" ];
  };
}
