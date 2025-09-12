{
  settings,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ../../hosts/${settings.system.host}
    ../../modules/nixos/system/kernel.nix
    ../../modules/nixos/system/locale.nix
    ../../modules/nixos/system/networking.nix
    ../../modules/nixos/system/nix.nix
    ../../modules/nixos/system/pipewire.nix
    ../../modules/nixos/system/time.nix
    ../../modules/nixos/system/users.nix
    ../../modules/nixos/desktop/hyprland.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs settings; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${settings.user.username} = import ./home.nix;
  };

  environment.shells = with pkgs; [
    bash
    fish
  ];

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  system.stateVersion = "25.05";
}
