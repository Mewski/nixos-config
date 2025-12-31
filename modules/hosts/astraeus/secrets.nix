{ inputs, self, ... }:
let
  nginxSecret = {
    owner = "nginx";
    group = "nginx";
  };
  gitSecret = {
    owner = "git";
    group = "git";
  };
in
{
  flake.nixosModules.astraeus = {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    fileSystems."/etc/ssh".neededForBoot = true;

    sops = {
      defaultSopsFile = "${self}/secrets/astraeus/secrets.yaml";
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

      secrets = {
        "cloudflare/cert" = nginxSecret;
        "cloudflare/key" = nginxSecret;

        "gitlab/active_record_deterministic_key" = gitSecret;
        "gitlab/active_record_primary_key" = gitSecret;
        "gitlab/active_record_salt" = gitSecret;
        "gitlab/db_password" = gitSecret;
        "gitlab/db_secret" = gitSecret;
        "gitlab/initial_root_password" = gitSecret;
        "gitlab/jws" = gitSecret;
        "gitlab/otp" = gitSecret;
        "gitlab/secret" = gitSecret;

        "gitlab-runner/token" = { };
      };
    };
  };
}
