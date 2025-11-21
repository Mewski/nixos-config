{ inputs, ... }:
{
  flake.nixosModules.secrets =
    { config, ... }:
    {
      imports = [
        inputs.sops-nix.nixosModules.sops
      ];

      fileSystems."/etc/ssh".neededForBoot = true;

      sops = {
        defaultSopsFile = ../../../secrets/zephyrus.yaml;

        age.keyFile = "/home/${config.preferences.user.username}/.config/sops/age/keys.txt";

        age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      };

      persist.files = [
        ".config/sops/age/keys.txt"
      ];
    };
}
