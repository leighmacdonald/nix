{
  pkgs,
  username,
  ...
}:
{
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
  networking.firewall.allowedUDPPorts = [
    80
    443
  ];
  systemd.services.caddy = {
    serviceConfig.EnvironmentFile = [
      "/etc/caddy/envfile"
    ];
  };
  sops.secrets."caddy_cf_env" = {
    path = "/etc/caddy/envfile";
  };
  services.caddy = {
    enable = true;
    environmentFile = "/etc/caddy/envfile";

    email = "leigh.macdonald@gmail.com";
    virtualHosts = {
      "bt.roto.lol" = {
        extraConfig = ''
          log  {
              output discard
          }
          tls {
              dns cloudflare {$API_KEY}
          }
          reverse_proxy /* rupert.roto.lol:8080 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
        '';
      };
      "gbans.roto.lol" = {
        extraConfig = ''
          log  {
              output discard
          }
          tls {
              dns cloudflare {$API_KEY}
          }

          @cloudflare {
              remote_ip 173.245.48.0/20 103.21.244.0/22 103.22.200.0/22 103.31.4.0/22 141.101.64.0/18 108.162.192.0/18 190.93.240.0/20 188.114.96.0/20 197.234.240.0/22 198.41.128.0/17 162.158.0.0/15 104.16.0.0/13 104.24.0.0/14 172.64.0.0/13 131.0.72.0/22 2400:cb00::/32 2606:4700::/32 2803:f800::/32 2405:b500::/32 2405:8100::/32 2a06:98c0::/29 2c0f:f248::/32
          }

          handle @cloudflare {
            reverse_proxy /* frankie.roto.lol:6007 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
              header_up X-Forwarded-For {http.request.header.CF-Connecting-IP}
            }
          }
          handle {
              respond "?" 403
          }
        '';
      };
      "radarr.roto.lol" = {
        extraConfig = ''
          log  {
              output discard
          }
          tls {
              dns cloudflare {$API_KEY}
          }
          reverse_proxy /* rupert.roto.lol:7878 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
        '';
      };
      "llm.roto.lol" = {
        extraConfig = ''
          log  {
              output discard
          }
          tls {
              dns cloudflare {$API_KEY}
          }
          reverse_proxy /* frankie.roto.lol:8080 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
        '';
      };
      "autocomplete.roto.lol" = {
        extraConfig = ''
          log  {
              output discard
          }
          tls {
              dns cloudflare {$API_KEY}
          }
          reverse_proxy /* frankie.roto.lol:8081 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
        '';
      };
      "oc.roto.lol" = {
        extraConfig = ''
          basic_auth {
            ${username} {$BASIC_AUTH_PASSWORD}
          }
          log  {
              output discard
          }
          tls {
              dns cloudflare {$API_KEY}
          }
          reverse_proxy /* frankie.roto.lol:8090 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
        '';
      };
      "lidarr.roto.lol" = {
        extraConfig = ''
          log  {
              output discard
          }
          tls {
              dns cloudflare {$API_KEY}
          }
          reverse_proxy /* rupert.roto.lol:8686 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
        '';
      };
      "sonarr.roto.lol" = {
        extraConfig = ''
          log  {
              output discard
          }
          tls {
              dns cloudflare {$API_KEY}
          }
          reverse_proxy /* rupert.roto.lol:8989 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
        '';
      };
      "bazarr.roto.lol" = {
        extraConfig = ''
          log {
              output discard
          }
          tls {
              dns cloudflare {$API_KEY}
          }
          reverse_proxy /* rupert.roto.lol:6767 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
        '';
      };
      "autobrr.roto.lol" = {
        extraConfig = ''
          log {
              output discard
          }
          tls {
              dns cloudflare {$API_KEY}
          }

          reverse_proxy /* rupert.roto.lol:7474 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
        '';
      };
      "prowlarr.roto.lol" = {
        extraConfig = ''
          log {
              output discard
          }
          tls {
              dns cloudflare {$API_KEY}
          }
          reverse_proxy /* rupert.roto.lol:9696 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
        '';
      };
      "overseerr.roto.lol" = {
        extraConfig = ''
          log {
              output discard
          }
          tls {
              dns cloudflare {$API_KEY}
          }
          reverse_proxy /* rupert.roto.lol:5055 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
        '';
      };
      "pgadmin.roto.lol" = {
        extraConfig = ''
          log {
              output discard
          }
          reverse_proxy /* rupert.roto.lol:5050 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          tls {
              dns cloudflare {$API_KEY}
          }
        '';
      };
      "jellyfin.roto.lol" = {
        extraConfig = ''
          log {
              output discard
          }
          tls {
              dns cloudflare {$API_KEY}
          }
          reverse_proxy /* rupert.roto.lol:8096 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
          }
          reverse_proxy /socket/* rupert.roto.lol:8096 {
              header_up Host {host}
              header_up X-Real-IP {remote_host}
              header_up Connection {>Connection}
              header_up Upgrade {>Upgrade}
          }
        '';
      };
    };
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
      #hash = "sha256-bzMqxWTqrJ1skZmRTXyEMCKStXpljbqe5r0Ve2cnBfM=";
      hash = "sha256-hEHgAG0F0ozHRAPuxEqLyTATBrE+pajeXDiSNwniorg=";
    };
  };
}
