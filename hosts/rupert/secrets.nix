{ username, ... }:

let
  mode = "666";
in
{
  sops.secrets = {
    prowlarr_env = {
      inherit mode;
    };
    sonarr_env = {
      inherit mode;
    };
    radarr_env = {
      inherit mode;
    };
    lidarr_env = {
      inherit mode;
    };
    # Bare API keys for the exportarr Prometheus exporters.
    sonarr_api_key = { };
    radarr_api_key = { };
    lidarr_api_key = { };
    prowlarr_api_key = { };
    listenbrainz_token = {
      owner = username;
    };
    # Cloudflare Tunnel credentials JSON (`cloudflared tunnel create rupert`).
    # Loaded by the cloudflared systemd service via LoadCredential, so the
    # default root-owned 0400 mode is correct.
    "cloudflared-tunnel.json" = { };
    "beets.yaml" = {
      owner = username;
      mode = "777"; # FIXME
    };
  };
}
