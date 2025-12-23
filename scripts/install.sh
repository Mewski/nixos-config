#!/bin/bash
set -u

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}

usage() {
  cat <<EOF
Usage: $0 <hostname>

Available hosts:
  zephyrus   - ASUS ROG Zephyrus GU605MY
  crosshair  - ASUS ROG Crosshair X670E Hero
  astraeus   - Supermicro X10DRT-H
EOF
  exit "${1:-0}"
}

[[ $# -eq 0 ]] && usage 1
[[ "$1" == "-h" || "$1" == "--help" ]] && usage

HOST="$1"
REPO="github:Mewski/nixos-config"

declare -A SUBSTITUTERS=(
  ["zephyrus"]="https://nix-community.cachix.org https://hyprland.cachix.org https://cache.nixos-cuda.org"
  ["crosshair"]="https://nix-community.cachix.org https://hyprland.cachix.org https://cache.nixos-cuda.org"
  ["astraeus"]="https://nix-community.cachix.org"
)

declare -A KEYS=(
  ["zephyrus"]="nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc= cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
  ["crosshair"]="nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc= cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
  ["astraeus"]="nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
)

[[ -v "SUBSTITUTERS[$HOST]" ]] || abort "Unknown host: $HOST" "" "Run '$0 --help' for available hosts."

echo "==> Partitioning disks for $HOST..."
nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- \
  --flake "$REPO#$HOST" --mode disko

cd /mnt || abort "Failed to cd to /mnt"

echo "==> Installing NixOS..."
nixos-install --flake "$REPO#$HOST" --no-write-lock-file \
  --option extra-substituters "${SUBSTITUTERS[$HOST]}" \
  --option extra-trusted-public-keys "${KEYS[$HOST]}" \

echo "==> Done! Reboot to complete installation."
