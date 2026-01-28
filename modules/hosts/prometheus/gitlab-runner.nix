{
  flake.nixosModules.prometheus =
    { config, ... }:
    {
      services.gitlab-runner = {
        enable = true;

        services.docker-runner = {
          authenticationTokenConfigFile = config.sops.secrets."gitlab-runner/token".path;
          dockerImage = "alpine:latest";
          executor = "docker";
        };
      };
    };
}
