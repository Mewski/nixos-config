{
  flake.nixosModules.fish = {
    programs.fish.enable = true;
  };

  flake.homeModules.fish =
    { pkgs, ... }:
    {
      programs.fish = {
        enable = true;

        loginShellInit = ''
          if test -z "$DISPLAY" -a "$XDG_VTNR" = "1"
            exec Hyprland
          end
        '';

        shellAliases = {
          snapshot-diff = ''
            sudo sh -c 'mkdir -p /mnt && \
            mount -o subvol=/ /dev/mapper/cryptroot /mnt && \
            LATEST=$(ls -t /mnt/snapshots/ | head -1) && \
            echo "Comparing current root with snapshot: $LATEST" && \
            ${pkgs.rsync}/bin/rsync -avun --delete /mnt/snapshots/$LATEST/ /mnt/root/ | grep -v "/$" && \
            umount /mnt'
          '';
        };
      };
    };
}
