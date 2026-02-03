{
  flake.overlays.pve-common = final: prev: {
    pve-common = prev.pve-common.overrideAttrs (old: {
      postPatch = (old.postPatch or "") + ''
        # Fix crypt hash algorithm - NixOS libxcrypt doesn't support SHA-256 ($5$)
        # Change default from SHA-256 to SHA-512 ($6$) and add $6$ support
        substituteInPlace src/PVE/Tools.pm \
          --replace-fail "\$prefix = '5' if !\$prefix;" "\$prefix = '6' if !\$prefix;" \
          --replace-fail "if (\$prefix eq '5') {" "if (\$prefix eq '6') {
          \$input = \"\\\$6\\\$\$salt\\\$\";
        } elsif (\$prefix eq '5') {"
      '';
    });
  };
}
