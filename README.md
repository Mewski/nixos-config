# NixOS Config

A modular NixOS configuration built with flakes, featuring impermanence, secure boot, and a Hyprland desktop environment.

## Features

- **Flakes** - Reproducible system configuration with pinned dependencies
- **Impermanence** - Root filesystem is wiped on every boot, with snapshots retained for 7 days
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
- Dynamic refresh rate (240Hz on AC, 60Hz on battery)

### Astraeus

Supermicro SYS-2028TR-HTR with:
- Intel Xeon dual processor system
- 6x Samsung 1.9TB enterprise SSDs in ZFS raidz2 (~7TB usable)
- UEFI boot with GRUB mirrored across all 6 drives
- Disko for declarative ZFS pool management
- NixOS stable (25.11) for reliability

## Structure

```
modules/
  desktops/hyprland/  # Hyprland config (binds, devices, layout, visuals)
  features/           # System features (nix, nvidia, impermanence, user, virtualization)
  hosts/zephyrus/     # Host-specific config (asusd, disko, persist, power, secrets, wireguard)
  profiles/           # Composable system profiles (desktop)
  programs/           # User applications (fish, git, kitty, nixvim, zed-editor, zen-browser, etc.)
  services/           # System services (pipewire, docker, dunst, mullvad-vpn)
  theme/              # Per-application theming via base16
```

## Install

### Zephyrus

```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --flake github:Mewski/nixos-config#zephyrus --mode disko
cd /mnt
sudo nixos-install --flake github:Mewski/nixos-config#zephyrus --no-write-lock-file
```

### Astraeus

```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --flake github:Mewski/nixos-config#astraeus --mode disko
cd /mnt
sudo nixos-install --flake github:Mewski/nixos-config#astraeus --no-write-lock-file
```

## Rebuild

```bash
sudo nixos-rebuild switch --flake ~/.nixos-config
```

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
