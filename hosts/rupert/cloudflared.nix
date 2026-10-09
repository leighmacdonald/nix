# Cloudflare Tunnel fronting all public services, replacing Caddy on winnie.
#
# Setup (tunnel already created; credentials in secrets.yaml as
# "cloudflared-tunnel.json"). Remaining before traffic flows:
#   1. For each hostname in ingress below, create a DNS CNAME in Cloudflare:
#        <host>  CNAME  2113e6b1-f6d7-45b4-a90b-2af19588bc1e.cfargotunnel.com
#        (proxied). This replaces the old A records.
#   2. Deploy: `just rupert` (tunnel comes up), then `just winnie`.
#      ddns-updater was removed entirely: tunnel CNAMEs are static, and the
#      leftover non-tunnel records (metrics, slskd, speedtest, syncthing,
#      tf-api-dev) no longer get dynamic updates.
#
# Notes:
# - TLS terminates at the Cloudflare edge; origins are plain HTTP.
# - gbans' old IP-allowlist is obsolete: tunnel ingress only accepts
#   traffic from the Cloudflare edge. Use a Zero Trust Access policy for
#   gbans/oc if you want identity-based auth (oc previously had basic_auth
#   in Caddy, which has no equivalent here).
{ config, ... }:
{
  services.cloudflared = {
    enable = true;
    tunnels = {
      # 2113e6b1-f6d7-45b4-a90b-2af19588bc1e.cfargotunnel.com
      "2113e6b1-f6d7-45b4-a90b-2af19588bc1e" = {
        credentialsFile = config.sops.secrets."cloudflared-tunnel.json".path;
        default = "http_status:404";
        ingress = {
          # rupert-local services (tunnel origin = this host)
          # "autobrr.roto.lol" = "http://127.0.0.1:7474";
          "bazarr.roto.lol" = "http://127.0.0.1:6767";
          "bt.roto.lol" = "http://127.0.0.1:8080";
          "jellyfin.roto.lol" = "http://192.168.0.201:8096";
          "lidarr.roto.lol" = "http://127.0.0.1:8686";
          "overseerr.roto.lol" = "http://192.168.0.201:5055";
          "metrics.roto.lol" = "http://192.168.0.201:5055";
          # "pgadmin.roto.lol" = "http://127.0.0.1:5050";
          "prowlarr.roto.lol" = "http://127.0.0.1:9696";
          "radarr.roto.lol" = "http://127.0.0.1:7878";
          "sonarr.roto.lol" = "http://127.0.0.1:8989";
          # frankie services, reached over the LAN (same mapping Caddy used)
          "gbans.roto.lol" = "http://192.168.0.200:6007";
        };
      };
    };
  };
}
