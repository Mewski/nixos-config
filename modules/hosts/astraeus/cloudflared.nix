{
  flake.nixosModules.astraeus =
    { config, pkgs, ... }:
    {
      systemd.services.cloudflared-tunnel = {
        description = "Cloudflare Tunnel";
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          DynamicUser = true;
          EnvironmentFile = config.sops.secrets."cloudflared/tunnel_token".path;
          ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token \${TUNNEL_TOKEN}";
          Restart = "on-failure";
          RestartSec = 5;
        };
      };
    };
}
