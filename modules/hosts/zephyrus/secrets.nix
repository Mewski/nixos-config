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

        secrets.wakatime-api-key = {
          sopsFile = ../../../secrets/common.yaml;
          owner = config.preferences.user.username;
          mode = "0400";
        };
      };

      persist.files = [
        ".config/sops/age/keys.txt"
      ];
    };
}
