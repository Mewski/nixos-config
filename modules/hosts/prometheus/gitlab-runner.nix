{
  flake.nixosModules.prometheus =
    { config, ... }:
    {
      services.gitlab-runner = {
        enable = true;

        services.docker-runner = {
          authenticationTokenConfigFile = config.sops.secrets."gitlab-runner/token".path;
          dockerImage = "alpine:latest";
          dockerPrivileged = true;
          dockerVolumes = [
            "/certs/client"
          ];
          environmentVariables = {
            DOCKER_TLS_CERTDIR = "/certs";
            DOCKER_CERT_PATH = "/certs/client";
            DOCKER_HOST = "tcp://docker:2376";
            DOCKER_TLS_VERIFY = "1";
          };
          executor = "docker";
        };
      };
    };
}
