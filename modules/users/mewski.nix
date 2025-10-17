{
  flake.nixosModules.mewski =
    { pkgs, ... }:
    {
      users.users.mewski = {
        isNormalUser = true;
        description = "Mewski";
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        shell = pkgs.fish;
      };
    };
}
