# NixOS Config

Modular NixOS configuration using flakes with impermanence, secure boot, and Hyprland.

## Structure

```
modules/
  desktops/hyprland/  # Hyprland (binds, devices, layout, visuals)
  features/           # flatpak, home-manager, nix, nvidia, virtualization
  hosts/              # Host-specific configs
  overlays/           # spotx
  profiles/           # desktop, development, gaming, server
  programs/           # fish, git, kitty, nixvim, zed-editor, zen-browser, etc.
  services/           # pipewire, docker, dunst
  theme/              # base16 theming (gtk, qt, hyprland, kitty, etc.)
```

## Install

```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/Mewski/nixos-config/master/scripts/install.sh)" -- <hostname>
```

## Rebuild

```bash
sudo nixos-rebuild switch --flake github:Mewski/nixos-config --refresh
```

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
