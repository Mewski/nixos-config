{
  flake.nixosModules.astraeus =
    { config, pkgs, ... }:
    let
      domain = "gitlab.mewski.dev";
      registryDomain = "registry.gitlab.mewski.dev";
      pagesDomain = "pages.mewski.dev";
      listenAddr = "[2601:244:4b06:5be2::10]";

      sslConfig = {
        forceSSL = true;
        sslCertificate = config.sops.secrets."cloudflare/cert".path;
        sslCertificateKey = config.sops.secrets."cloudflare/key".path;
        listen = [
          {
            addr = listenAddr;
            port = 443;
            ssl = true;
          }
        ];
      };

      cloudflareIPs = [
        "173.245.48.0/20"
        "103.21.244.0/22"
        "103.22.200.0/22"
        "103.31.4.0/22"
        "141.101.64.0/18"
        "108.162.192.0/18"
        "190.93.240.0/20"
        "188.114.96.0/20"
        "197.234.240.0/22"
        "198.41.128.0/17"
        "162.158.0.0/15"
        "104.16.0.0/13"
        "104.24.0.0/14"
        "172.64.0.0/13"
        "131.0.72.0/22"
        "2400:cb00::/32"
        "2606:4700::/32"
        "2803:f800::/32"
        "2405:b500::/32"
        "2405:8100::/32"
        "2a06:98c0::/29"
        "2c0f:f248::/32"
      ];

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

      services.nginx.commonHttpConfig = ''
        ${builtins.concatStringsSep "\n" (map (ip: "set_real_ip_from ${ip};") cloudflareIPs)}
        real_ip_header CF-Connecting-IP;
      '';

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
