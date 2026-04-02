{ inputs, self, ... }:
{
  flake.nixosModules.crosshair = {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    home-manager.sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];

    sops = {
      defaultSopsFile = "${self}/secrets/crosshair/secrets.yaml";
      age.sshKeyPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
    };
  };

  flake.homeModules.crosshair =
    { config, ... }:
    {
      sops = {
        age.keyFile = ".config/sops/age/keys.txt";
        secrets = {
          wakatime_api_key = {
            sopsFile = "${self}/secrets/shared/secrets.yaml";
          };
          binary_ninja_license = {
            sopsFile = "${self}/secrets/shared/secrets.yaml";
            path = ".binaryninja/license.dat";
          };
        };
        templates."wakatime.cfg" = {
          path = ".wakatime.cfg";
          content = ''
            [settings]
            api_key=${config.sops.placeholder.wakatime_api_key}
            sync_ai_disabled=true
          '';
        };
      };
    };
}
