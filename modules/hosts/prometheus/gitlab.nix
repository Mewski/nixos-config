{
  flake.nixosModules.prometheus =
    { config, pkgs, ... }:
    let
      domain = "gitlab.mewski.dev";
      registryDomain = "registry.gitlab.mewski.dev";
      pagesDomain = "pages.mewski.dev";

      sslConfig = {
        forceSSL = true;
        sslCertificate = config.sops.secrets."cloudflare/cert".path;
        sslCertificateKey = config.sops.secrets."cloudflare/key".path;
      };

      proxyHeaders = ''
        proxy_set_header X-Forwarded-Proto https;
        proxy_set_header X-Forwarded-Ssl on;
      '';
    in
    {
      services.gitlab = {
        enable = true;
        packages.gitlab = pkgs.gitlab-ee;

        host = domain;
        port = 443;
        https = true;

        user = "git";
        group = "git";
        databaseUsername = "git";

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
          domain = domain;
          enableStartTLSAuto = true;
        };

        registry = {
          enable = true;
          host = registryDomain;
          port = 5000;
          externalAddress = registryDomain;
          externalPort = 443;
          certFile = "/var/lib/gitlab/registry/registry-auth.crt";
          keyFile = "/var/lib/gitlab/registry/registry-auth.key";
        };

        pages = {
          enable = true;
          settings = {
            pages-domain = pagesDomain;
            listen-proxy = [ "127.0.0.1:8090" ];
          };
        };

        extraConfig = {
          gitlab = {
            email_display_name = "GitLab";
            email_from = "gitlab@${domain}";
            email_reply_to = "no-reply@${domain}";
            ssh_host = "ssh.${domain}";

            include_optional_metrics_in_service_ping = false;
            usage_ping_enabled = false;
            usage_ping_generation_enabled = false;
          };

          pages = {
            enabled = true;
            host = pagesDomain;
            port = 443;
            https = true;
          };

          gitlab_kas.enabled = false;
        };
      };

      services.nginx.virtualHosts = {
        ${domain} = sslConfig // {
          locations."/" = {
            proxyPass = "http://unix:/run/gitlab/gitlab-workhorse.socket";
            proxyWebsockets = true;
            extraConfig = proxyHeaders;
          };
        };

        ${registryDomain} = sslConfig // {
          locations."/" = {
            proxyPass = "http://127.0.0.1:5000";
            extraConfig = ''
              client_max_body_size 0;
              ${proxyHeaders}
            '';
          };
        };

        "~^(?<subdomain>.+)\\.${builtins.replaceStrings [ "." ] [ "\\." ] pagesDomain}$" = sslConfig // {
          locations."/" = {
            proxyPass = "http://127.0.0.1:8090";
            extraConfig = proxyHeaders;
          };
        };
      };
    };
}
