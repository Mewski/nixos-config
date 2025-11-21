{ inputs, ... }:
{
  flake.nixosModules.secrets = {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    fileSystems."/etc/ssh".neededForBoot = true;

    sops = {
      defaultSopsFile = ../../../secrets/zephyrus.yaml;

      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };

    persist.files = [
      ".config/sops/age/keys.txt"
    ];
  };
}
