# NixOS Configuration

A declarative NixOS configuration featuring Hyprland, Stylix theming, and modular organization.

## Features

- **Window Manager**: Hyprland with custom keybindings and animations
- **Theming**: Stylix for system-wide color scheme management
- **Security**: Lanzaboote for secure boot implementation
- **Applications**: Curated set of modern applications and tools
- **Hardware Support**: Optimized for ASUS Zephyrus G16 with NVIDIA GPU

## Structure

- `flake.nix` - Main flake configuration with inputs and outputs
- `settings.nix` - Centralized configuration parameters
- `hosts/` - Host-specific hardware configurations
- `modules/` - Modular system and home-manager configurations
- `profiles/` - System profiles (desktop, server, etc.)
- `themes/` - Custom color schemes and wallpapers

## Usage

1. Clone this repository
2. Update `settings.nix` with your preferences
3. Build and switch: `sudo nixos-rebuild switch --flake .`

## Customization

- Edit `settings.nix` to change system parameters
- Add new themes in `themes/` directory
- Modify application configs in `modules/home-manager/applications/`
- Adjust hardware settings in `hosts/your-host/`
