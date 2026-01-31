# NixOS Configuration

Declarative NixOS configurations using flakes.

## Installation

```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount --flake github:Mewski/nixos-config#<hostname>
sudo nixos-install --flake github:Mewski/nixos-config#<hostname>
```

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
