# Hyprland Removal And Formatting Design

## Goal

Remove Hyprland from the NixOS flake and make formatting consistent through `nix fmt`.

## Scope

- Remove Hyprland inputs, modules, host-specific files, imports, and Cachix settings.
- Move Crosshair from Hyprland to Niri.
- Keep Zephyrus on Niri.
- Add a flake formatter matching existing editor expectations around `nixfmt`.
- Run formatter over Nix files and keep cleanup limited to stale references and obvious consistency issues.
- Verify every host configuration evaluates, or report unrelated blockers.

## Approach

The flake already uses `import-tree`, so deleting Hyprland module files is enough to remove exported Hyprland modules once no host imports them. Crosshair will import `self.nixosModules.niri`, matching Zephyrus. Hyprland-specific Cachix entries will be removed from host cache modules.

The formatter will be declared in `perSystem` as `formatter = pkgs.nixfmt-rfc-style` when available from nixpkgs. If unavailable, use `pkgs.nixfmt` so `nix fmt` works consistently with existing editor setup.

## Verification

- `nix fmt`
- Search for remaining Hyprland references in Nix files.
- `nix flake lock` after input removal, if needed, to prune lock entries.
- Evaluate all `nixosConfigurations.*.config.system.build.toplevel.drvPath` values.
