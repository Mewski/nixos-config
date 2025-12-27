# NixOS Configuration

Declarative NixOS configurations using flakes.

## Hosts

| Host | Hardware | Profile |
|------|----------|---------|
| zephyrus | ASUS ROG Zephyrus GU605MY | desktop, development, gaming |
| crosshair | ASUS ROG Crosshair X670E Hero | desktop, development, gaming |
| astraeus | Supermicro X10DRT-H | server |

## Features

- **Flakes** - Reproducible, pinned dependencies
- **Impermanence** - Ephemeral root with `/persist`
- **Lanzaboote** - Secure boot
- **Home Manager** - User environment
- **SOPS** - Secrets management
- **Base16** - Unified theming

## Stack

| Category | Tools |
|----------|-------|
| Compositor | Hyprland |
| Terminal | kitty, fish |
| Editor | zed-editor, nixvim |
| Browser | zen-browser |
| Bar | waybar |
| Launcher | rofi |
| Notifications | dunst |

## Structure

```
modules/
├── desktops/        # Hyprland config
├── features/        # nix, nvidia, flatpak, virtualization
├── hosts/           # Machine-specific config
├── overlays/        # Package overlays
├── profiles/        # desktop, development, gaming, server
├── programs/        # Application configs
└── theme/           # Base16 theming
secrets/             # SOPS encrypted secrets
```

## Usage

### Install

```sh
curl -fsSL https://raw.githubusercontent.com/Mewski/nixos-config/main/scripts/install.sh | sudo bash -s -- <host>
```

### Rebuild

```sh
sudo nixos-rebuild switch --flake github:Mewski/nixos-config --refresh
```

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
