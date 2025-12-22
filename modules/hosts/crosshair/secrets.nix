{ inputs, self, ... }:
{
  flake.nixosModules.crosshair = {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    home-manager.sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];

    fileSystems."/etc/ssh".neededForBoot = true;

    sops = {
      defaultSopsFile = "${self}/secrets/crosshair/secrets.yaml";

      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
  };

  flake.homeModules.crosshair = {
    sops = {
      age.keyFile = ".config/sops/age/keys.txt";

      secrets = {
        wakatime_api_key = {
          sopsFile = "${self}/secrets/shared/secrets.yaml";
          path = ".wakatime.cfg";
        };
        binary_ninja_license = {
          sopsFile = "${self}/secrets/shared/secrets.yaml";
          path = ".binaryninja/license.dat";
        };
      };
    };
  };
}
