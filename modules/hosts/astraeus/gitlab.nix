{
  flake.nixosModules.astraeus =
    { config, pkgs, ... }:
    {
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

        smtp = {
          enable = true;
          address = "smtp-relay.gmail.com";
          port = 587;
          domain = "gitlab.mewski.dev";
          tls = true;
        };

        extraConfig = {
          gitlab = {
            email_display_name = "GitLab";
            email_from = "gitlab@gitlab.mewski.dev";
            email_reply_to = "no-reply@gitlab.mewski.dev";

            default_theme = 2;
            default_syntax_highlighting_theme = 2;

            include_optional_metrics_in_service_ping = false;
            usage_ping_enabled = false;
            usage_ping_generation_enabled = false;
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
          listen = [
            {
              addr = "127.0.0.1";
              port = 8929;
            }
          ];
          locations."/" = {
            proxyPass = "http://unix:/run/gitlab/gitlab-workhorse.socket";
            proxyWebsockets = true;
            extraConfig = ''
              proxy_set_header X-Forwarded-Proto https;
              proxy_set_header X-Forwarded-Ssl on;
            '';
          };
        };
      };
    };
}
