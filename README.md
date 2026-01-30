# NixOS Configuration

Declarative NixOS configurations using flakes.

## Installation

```bash
nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount --flake .#<hostname>
nixos-install --flake .#<hostname>
```

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
