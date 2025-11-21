{
  flake.homeModules.wakatime =
    { lib, ... }:
    {
      home.activation.wakatime = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        printf "[settings]\napi_key=%s\n" "$(cat /run/secrets/wakatime-api-key)" > $HOME/.wakatime.cfg
        chmod 600 $HOME/.wakatime.cfg
      '';
    };
}
