{
  description = "github:Mewski/nixos-config";

  inputs = {
    # Core nixpkgs repository
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Stable nixpkgs repository
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Binary Ninja binary analysis platform
    binaryninja = {
      url = "github:jchv/nix-binary-ninja";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager for user environment management
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland window manager
    hyprland = {
      url = "github:hyprwm/Hyprland/main?submodules=true";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secure boot implementation
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Discord client with Vencord support
    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware configuration repository
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Neovim configuration framework
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    # Atomic, declarative, and reproducible secret provisioning for NixOS
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # System-wide theming framework
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Zen browser
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
