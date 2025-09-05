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
      url = "github:hyprwm/Hyprland/master?submodules=true";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware configurations
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    inputs@{ self, ... }:
    let
      settings = {
        # System settings
        system = rec {
          hostname = "nixos";
          host = "zephyrus";
          profile = "base";
          timezone = "America/Chicago";
          locale = "en_US.UTF-8";
          target = (import ./hosts/${host}/config.nix).target;
        };

        # User settings
        user = {
          username = "mewski";
          name = "Mewski";
          email = "admin@mewski.dev";
          theme = "catppuccin-mocha";
        };
      };

      # Nixpkgs
      pkgs = import inputs.nixpkgs {
        system = settings.system.target;
        config = {
          allowUnfree = true;
        };
      };

      # Nixpkgs helper functions
      lib = inputs.nixpkgs.lib;

      # Home Manager
      home-manager = inputs.home-manager;
    in
    {
      nixosConfigurations = {
        ${settings.system.hostname} = lib.nixosSystem {
          system = settings.system.target;
          modules = [
            ./hosts/${settings.system.host}
            ./profiles/${settings.system.profile}/configuration.nix
          ];
          specialArgs = {
            inherit inputs settings;
          };
        };
      };
      homeConfigurations = {
        ${settings.user.username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./profiles/${settings.system.profile}/home.nix
          ];
          extraSpecialArgs = {
            inherit inputs settings;
          };
        };
      };
    };
}
