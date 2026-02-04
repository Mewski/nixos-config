{
  flake.nixosModules.prometheus =
    { config, ... }:
    let
      domain = "couchdb.mewski.dev";

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
      services.couchdb = {
        enable = true;
        bindAddress = "127.0.0.1";
        extraConfigFiles = [ config.sops.secrets."couchdb/config".path ];
        extraConfig = {
          couchdb = {
            single_node = true;
            max_document_size = 50000000;
          };
          chttpd = {
            require_valid_user = true;
            max_http_request_size = 4294967296;
          };
          chttpd_auth = {
            require_valid_user = true;
            authentication_redirect = "/_utils/session.html";
          };
          httpd = {
            WWW-Authenticate = ''Basic realm="couchdb"'';
            enable_cors = true;
          };
          cors = {
            origins = "app://obsidian.md,capacitor://localhost,http://localhost";
            credentials = true;
            methods = "GET, PUT, POST, HEAD, DELETE";
            headers = "accept, authorization, content-type, origin, referer";
          };
        };
      };

      services.nginx.virtualHosts.${domain} = sslConfig // {
        locations."/" = {
          proxyPass = "http://127.0.0.1:5984";
          proxyWebsockets = true;
          extraConfig = ''
            client_max_body_size 0;
            ${proxyHeaders}
          '';
        };
      };
    };
}
