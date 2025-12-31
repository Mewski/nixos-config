{ inputs, self, ... }:
{
  flake.nixosModules.astraeus = {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    fileSystems."/etc/ssh".neededForBoot = true;

    sops = {
      defaultSopsFile = "${self}/secrets/astraeus/secrets.yaml";

      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

      secrets = {
        "cloudflare/cert" = {
          owner = "nginx";
          group = "nginx";
        };
        "cloudflare/key" = {
          owner = "nginx";
          group = "nginx";
        };
        "gitlab/active_record_deterministic_key" = {
          owner = "git";
          group = "git";
        };
        "gitlab/active_record_primary_key" = {
          owner = "git";
          group = "git";
        };
        "gitlab/active_record_salt" = {
          owner = "git";
          group = "git";
        };
        "gitlab/db_password" = {
          owner = "git";
          group = "git";
        };
        "gitlab/db_secret" = {
          owner = "git";
          group = "git";
        };
        "gitlab/initial_root_password" = {
          owner = "git";
          group = "git";
        };
        "gitlab/jws" = {
          owner = "git";
          group = "git";
        };
        "gitlab/otp" = {
          owner = "git";
          group = "git";
        };
        "gitlab/secret" = {
          owner = "git";
          group = "git";
        };
        "gitlab-runner/token" = {
          owner = "gitlab-runner";
          group = "gitlab-runner";
        };
      };
    };
  };
}
