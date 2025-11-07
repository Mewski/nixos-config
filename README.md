# NixOS Configuration

```bash
nix-shell -p git
git clone https://github.com/Mewski/nixos-config.git
cd nixos-config
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --flake .#zephyrus --mode destroy,format,mount /dev/nvme0n1
cd /mnt
sudo nixos-install
```
