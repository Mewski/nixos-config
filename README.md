# NixOS Config

A modular NixOS configuration built with flakes, featuring impermanence, secure boot, and a Hyprland desktop environment.

## Features

- **Flakes** - Reproducible system configuration with pinned dependencies
- **Impermanence** - Root filesystem is wiped on every boot, with snapshots retained for 30 days
- **Secure Boot** - Lanzaboote integration for signed boot chain
- **Secrets Management** - sops-nix with age encryption for managing sensitive data
- **Theming** - Unified theming across applications via base16
- **Home Manager** - Declarative user environment configuration

## Hosts

### Zephyrus

ASUS ROG Zephyrus GU605MY with:
- NVIDIA GPU (hybrid graphics with CUDA support)
- Hyprland compositor with waybar, rofi, dunst
- asusd for ASUS-specific hardware control
- Disko for declarative disk partitioning (LUKS + Btrfs)

## Structure

```
modules/
  desktops/   # Window manager configs (Hyprland)
  features/   # System features (nix, nvidia, impermanence, user, etc.)
  hosts/      # Host-specific configurations
  profiles/   # Composable system profiles (desktop)
  programs/   # User applications (fish, git, kitty, nixvim, etc.)
  services/   # System services (pipewire, docker, hypridle, dunst)
  theme/      # Per-application theming via base16
secrets/      # Encrypted secrets managed by sops-nix
```

## Install (Zephyrus)

```bash
nix-shell -p git gh
gh auth login
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --flake github:Mewski/nixos-config#zephyrus --mode disko
cd /mnt
sudo nixos-install --flake github:Mewski/nixos-config#zephyrus?submodules=1 --no-write-lock-file
```

## Rebuild

```bash
sudo nixos-rebuild switch --flake ~/.nixos-config?submodules=1
```

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
