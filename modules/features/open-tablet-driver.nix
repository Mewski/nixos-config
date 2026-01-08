{
  flake.nixosModules.open-tablet-driver = {
    hardware = {
      opentabletdriver.enable = true;
      uinput.enable = true;
    };
  };
}
