# NixOS Configuration

```bash
nix-shell -p git
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --flake github:Mewski/nixos-config#zephyrus --mode disko
cd /mnt
sudo nixos-install --flake github:Mewski/nixos-config#zephyrus --no-write-lock-file
```
