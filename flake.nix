{
  description = "github:Mewski/nixos-config";

  inputs = {
    # Core inputs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland/main?submodules=true";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # San Francisco Fonts
    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Lanzaboote
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware configurations
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Zen Browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, ... }:
    let
      # Import configuration settings
      inherit (import ./settings.nix) settings;

      # Nixpkgs helper functions
      lib = inputs.nixpkgs.lib;
    in
    {
      # NixOS system configurations
      nixosConfigurations = {
        ${settings.system.hostname} = lib.nixosSystem {
          system = (import ./hosts/${settings.system.host}/config.nix).target;
          modules = [
            # Import home-manager as a NixOS module
            inputs.home-manager.nixosModules.home-manager

            # Import stylix as a NixOS module
            inputs.stylix.nixosModules.stylix

            # Host and profile configurations
            ./hosts/${settings.system.host}
            ./profiles/${settings.system.profile}/configuration.nix
          ];
          specialArgs = {
            inherit inputs settings;
          };
        };
      };
    };
}
