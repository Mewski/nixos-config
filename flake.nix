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

    # Lanzaboote
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware configurations
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Zen Browser
    url = "github:0xc000022070/zen-browser-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ self, ... }:
    let
      # Centralized configuration settings
      settings = {
        # System settings
        system = rec {
          hostname = "nixos";
          host = "zephyrus";
          profile = "desktop";
          timezone = "America/Chicago";
          locale = "en_US.UTF-8";
          # Import target architecture from host config
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

      # Nixpkgs with unfree packages enabled
      pkgs = import inputs.nixpkgs {
        system = settings.system.target;
        config = {
          allowUnfree = true;
        };
      };

      # Nixpkgs helper functions
      lib = inputs.nixpkgs.lib;

      # Home Manager reference
      home-manager = inputs.home-manager;
    in
    {
      # NixOS system configurations
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

      # Home Manager configurations
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
