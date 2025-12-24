{
  flake.nixosModules.gitlab =
    { config, pkgs, ... }:
    let
      inherit (config.services.gitlab) user group;
    in
    {
      networking.firewall.allowedTCPPorts = [
        80
        443
      ];

      systemd.services.cloudflared-tunnel = {
        description = "Cloudflare Tunnel";
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token \${TUNNEL_TOKEN}";
          EnvironmentFile = config.sops.secrets."cloudflared/tunnel_token".path;
          Restart = "on-failure";
          RestartSec = 5;
          DynamicUser = true;
        };
      };

      services.gitlab = {
        enable = true;
        packages.gitlab = pkgs.gitlab-ee;
        host = "gitlab.mewski.dev";
        port = 443;
        https = true;
        user = "gitlab";
        group = "gitlab";

        databasePasswordFile = config.sops.secrets."gitlab/db_password".path;
        initialRootPasswordFile = config.sops.secrets."gitlab/initial_root_password".path;

        secrets = {
          activeRecordDeterministicKeyFile =
            config.sops.secrets."gitlab/active_record_deterministic_key".path;
          activeRecordPrimaryKeyFile = config.sops.secrets."gitlab/active_record_primary_key".path;
          activeRecordSaltFile = config.sops.secrets."gitlab/active_record_salt".path;
          dbFile = config.sops.secrets."gitlab/db_secret".path;
          jwsFile = config.sops.secrets."gitlab/jws".path;
          otpFile = config.sops.secrets."gitlab/otp".path;
          secretFile = config.sops.secrets."gitlab/secret".path;
        };

        extraConfig = {
          gitlab = {
            default_theme = 2;
            email_display_name = "GitLab";
            email_from = "gitlab@gitlab.mewski.dev";
            usage_ping_enabled = false;
          };
          gitlab_kas.enabled = false;
        };
      };

      services.nginx = {
        enable = true;
        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;

        virtualHosts."gitlab.mewski.dev" = {
          locations."/".proxyPass = "http://unix:/run/gitlab/gitlab-workhorse.socket";
          locations."/".proxyWebsockets = true;
        };
      };

      sops.secrets = {
        "cloudflared/tunnel_token" = { };
        "gitlab/active_record_deterministic_key" = {
          owner = user;
          inherit group;
        };
        "gitlab/active_record_primary_key" = {
          owner = user;
          inherit group;
        };
        "gitlab/active_record_salt" = {
          owner = user;
          inherit group;
        };
        "gitlab/db_password" = {
          owner = user;
          inherit group;
        };
        "gitlab/db_secret" = {
          owner = user;
          inherit group;
        };
        "gitlab/initial_root_password" = {
          owner = user;
          inherit group;
        };
        "gitlab/jws" = {
          owner = user;
          inherit group;
        };
        "gitlab/otp" = {
          owner = user;
          inherit group;
        };
        "gitlab/secret" = {
          owner = user;
          inherit group;
        };
      };
    };
}
