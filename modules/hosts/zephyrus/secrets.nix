{ inputs, ... }:
{
  flake.nixosModules.zephyrus = {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    home-manager.sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];

    fileSystems."/etc/ssh".neededForBoot = true;

    sops = {
      defaultSopsFile = ../../../secrets/zephyrus.yaml;

      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
  };

  flake.homeModules.zephyrus = {
    sops = {
      age.keyFile = ".config/sops/age/keys.txt";

      secrets = {
        wakatime-api-key = {
          sopsFile = ../../../secrets/common.yaml;
          path = ".wakatime.cfg";
        };
      };
    };
  };
}
