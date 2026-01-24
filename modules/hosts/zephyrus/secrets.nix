{ inputs, self, ... }:
{
  flake.nixosModules.zephyrus = {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    home-manager.sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];

    sops = {
      defaultSopsFile = "${self}/secrets/zephyrus/secrets.yaml";
      age.sshKeyPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];

      secrets = {
        "wireguard/ord-core-01/private_key" = { };
        "wireguard/ord-core-01/preshared_key" = { };
      };
    };
  };

  flake.homeModules.zephyrus = {
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
