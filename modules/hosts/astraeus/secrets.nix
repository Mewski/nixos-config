{ inputs, self, ... }:
{
  flake.nixosModules.astraeus = {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    fileSystems."/etc/ssh".neededForBoot = true;

    sops = {
      defaultSopsFile = "${self}/secrets/astraeus/secrets.yaml";

      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

      secrets = {
        "cloudflared/tunnel_token" = { };
        "gitlab/active_record_deterministic_key" = {
          owner = "gitlab";
          group = "gitlab";
        };
        "gitlab/active_record_primary_key" = {
          owner = "gitlab";
          group = "gitlab";
        };
        "gitlab/active_record_salt" = {
          owner = "gitlab";
          group = "gitlab";
        };
        "gitlab/db_password" = {
          owner = "gitlab";
          group = "gitlab";
        };
        "gitlab/db_secret" = {
          owner = "gitlab";
          group = "gitlab";
        };
        "gitlab/initial_root_password" = {
          owner = "gitlab";
          group = "gitlab";
        };
        "gitlab/jws" = {
          owner = "gitlab";
          group = "gitlab";
        };
        "gitlab/otp" = {
          owner = "gitlab";
          group = "gitlab";
        };
        "gitlab/secret" = {
          owner = "gitlab";
          group = "gitlab";
        };
      };
    };
  };
}
