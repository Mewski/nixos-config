# Hyprland Removal And Formatting Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove Hyprland entirely, switch Crosshair to Niri, add `nix fmt` support, and verify host evaluation.

**Architecture:** Keep desktop support centered on the existing Niri module. Use flake-level formatter output so formatting is a repo command rather than editor-only behavior. Delete obsolete Hyprland modules instead of leaving unused configuration around.

**Tech Stack:** Nix flakes, flake-parts, import-tree, NixOS modules, Home Manager modules, nixfmt.

---

### Task 1: Add Flake Formatter

**Files:**
- Modify: `flake.nix`

- [ ] Add `formatter = pkgs.nixfmt-rfc-style or pkgs.nixfmt;` inside `perSystem`.
- [ ] Run `nix eval .#formatter.x86_64-linux.name --raw` and expect a formatter package name.

### Task 2: Remove Hyprland Inputs

**Files:**
- Modify: `flake.nix`
- Modify: `flake.lock`

- [ ] Remove `hyprland`, `split-monitor-workspaces`, and `hyprland-plugins` inputs from `flake.nix`.
- [ ] Run `nix flake lock` to prune no-longer-used lock nodes.

### Task 3: Switch Crosshair To Niri

**Files:**
- Modify: `modules/hosts/crosshair/configuration.nix`

- [ ] Replace `self.nixosModules.hyprland` with `self.nixosModules.niri`.
- [ ] Keep existing Crosshair hardware, NVIDIA, desktop, development, gaming, and theme imports unchanged.

### Task 4: Delete Hyprland Modules

**Files:**
- Delete: `modules/desktops/hyprland/**`
- Delete: `modules/hosts/crosshair/hyprland.nix`
- Delete: `modules/hosts/zephyrus/hyprland.nix`

- [ ] Delete the shared Hyprland desktop module directory.
- [ ] Delete host-specific Hyprland files for Crosshair and Zephyrus.

### Task 5: Remove Hyprland Cachix Entries

**Files:**
- Modify: `modules/hosts/crosshair/cachix.nix`
- Modify: `modules/hosts/zephyrus/cachix.nix`

- [ ] Remove `https://hyprland.cachix.org` from substituters.
- [ ] Remove the matching `hyprland.cachix.org-1:...` trusted public key.

### Task 6: Format And Clean Nix Files

**Files:**
- Modify: Nix files changed by formatting.

- [ ] Run `nix fmt`.
- [ ] Review formatting diffs and keep only mechanical formatting plus requested cleanup.
- [ ] Search for `hyprland|Hyprland|split-monitor-workspaces|hyprland-plugins` in Nix files and remove stale references.

### Task 7: Verify All Hosts

**Files:**
- No direct edits unless verification exposes config errors caused by this cleanup.

- [ ] Run `nix flake show`.
- [ ] Evaluate every `nixosConfigurations.<host>.config.system.build.toplevel.drvPath`.
- [ ] Report any unrelated blockers separately from cleanup failures.
